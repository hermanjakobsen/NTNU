#include<stdio.h>
#include "elev.h"
#include "control.h"
#include "timer.h"
#include "utilities.h"
#include "queue.h"

enum state state_machine(enum state current_state)
{
	switch(current_state)
	{

		case INITIALIZE:
			initialize_hardware();
			initialize();
			next_state = IDLE;
			break;

		case IDLE:
			set_order();
			if (elev_get_stop_signal())
			{
				next_state = STOP_ENABLED;
				break;
			}
			choose_direction();
			break;


		case EXECUTE_ORDER:
			set_order();
			if(elev_get_stop_signal())
			{
				next_state = STOP_ENABLED;
				break;
			}
			check_if_order_is_complete();
			break;

		case ARRIVED:
			if (elev_get_stop_signal())
			{
				next_state = STOP_ENABLED;
				break;
			}
			set_order();
			arrived_procedure();
			break;

		case STOP_ENABLED:
			EM_stop_procedure();
			break;

		default:
			break;
	}
	return next_state;
}

void initialize_hardware()
{
	if (!elev_init())
	{
		printf("Unable to initialize elevator hardware!\n");
		next_state = FAILURE;
		return;
	}
}

void initialize()
{
	direction = -1;
	while(elev_get_floor_sensor_signal() == -1)
	{
		elev_set_motor_direction(direction);
	}
	stop_elev();
	close_door();
	set_floor_and_light();
	floor_reached = 1;
	printf("Ready to begin!\n");
}

void choose_direction()
{
	if (get_order_amount() != 0)
	{
		if ((get_order(current_floor, 0) || get_order(current_floor, 1) || get_order(current_floor, 2)) && elev_get_floor_sensor_signal() != -1) // Is already at floor
		{
			start_timer();
			next_state = ARRIVED;
		}

		else if(elev_get_floor_sensor_signal() == -1 && floor_reached == 0 && !order_is_in_dir()) // If the elevator is "stuck"
		{
			elev_set_motor_direction(last_direction * -1);
			next_state = EXECUTE_ORDER;
		}


		else if (order_is_in_dir())
		{
			elev_set_motor_direction(direction);
			floor_reached = 0;
			next_state = EXECUTE_ORDER;
		}

		else if (!order_is_in_dir())
		{
			direction *= -1; //Changes direction
			elev_set_motor_direction(direction);
			floor_reached = 0;
			next_state = EXECUTE_ORDER;
		}

	}
}

void check_if_order_is_complete()
{
	if (elev_get_floor_sensor_signal() == -1 && floor_reached == 0 ) // If the elevator is "stuck"
	{
		last_direction = direction;
	}
	if (elev_get_floor_sensor_signal() != -1) // The elevator is at a floor
	{
		set_floor_and_light();
		if (direction == 1)
		{
			if (get_order(current_floor, 1) || get_order(current_floor,2) || !order_is_in_dir()) //Stops at call-up or panel button or no more orders in direction
			{
				stop_elev();
				start_timer();
				next_state = ARRIVED;
			}
		}
		else if (direction == -1)
		{
			if (get_order(current_floor,0) || get_order(current_floor,2) || !order_is_in_dir()) //Stops at call-down or panel, etc
			{
				stop_elev();
				start_timer();
				next_state = ARRIVED;
			}
		}
	}
}

void arrived_procedure()
{
	floor_reached = 1;
	if(elev_get_floor_sensor_signal() != -1)
	{
		reset_order(current_floor);
	}
	open_door();	
	if(check_timer(3))
	{
		close_door();
		next_state = IDLE;
	}
}

void EM_stop_procedure()
{
	while(elev_get_stop_signal())
	{
		set_EM_stop();
		start_timer();
	}
	if (elev_get_floor_sensor_signal() != -1)
	{
		elev_set_stop_lamp(0);
		next_state = ARRIVED;
		return;
	}

	elev_set_stop_lamp(0);
	next_state = IDLE;
}
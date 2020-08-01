#include "utilities.h"
#include "queue.h"
void open_door(void)
{
	elev_set_door_open_lamp(1);
	//printf("Doors are open!\n");
}

void close_door(void)
{
	elev_set_door_open_lamp(0);
}

void stop_elev()
{
	elev_set_motor_direction(DIRN_STOP);
}

void set_EM_stop()
{
	stop_elev();
	elev_set_stop_lamp(1);
	for(int i= 0; i<= N_FLOORS-1; i++)
	{
		reset_order(i);
	}

	if(elev_get_floor_sensor_signal() != -1)
	{
		open_door();
	}

}

void set_floor_and_light()
{
	int temp_floor = elev_get_floor_sensor_signal();
	if(temp_floor >= 0)
	{
		current_floor = temp_floor;
		elev_set_floor_indicator(current_floor);
	}
}

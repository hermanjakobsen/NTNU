#include "queue.h"
#include "utilities.h"
// Each floor has three buttons; up, down and one in the elevator.
// order_buttons[floor][0] = call-down
// order_buttons[floor][1] = call-up
// order_buttons[floor][2] = order floor (in elevator)
// This means that order_buttons[0][0] (1st floor call-down) and
// order_buttons[3][1] (4th floor call-up) is invalid.


int order_buttons[N_FLOORS][3] = {{0}}; // All elements are initialized to 0.
int order_amount = 0;

//prøver å legge til slik at set_order også tar hensyn til opp- og nedknappene
void set_order()
{
	for (int floor = 0; floor < N_FLOORS; floor++)
	{
		if (elev_get_button_signal(BUTTON_COMMAND, floor))
		{
				elev_set_button_lamp(BUTTON_COMMAND, floor, 1);
				if(order_buttons[floor][2] != 1)
				{
					order_buttons[floor][2] = 1;
					order_amount++;
				}
		}

		if (floor < N_FLOORS-1)
		{
			if (elev_get_button_signal(BUTTON_CALL_UP, floor))
			{
				elev_set_button_lamp(BUTTON_CALL_UP, floor, 1);
				if (order_buttons[floor][1] != 1)
				{
					order_buttons[floor][1] = 1;
					order_amount++;
				}
			}
		}

		if(floor > 0)
		{
			if (elev_get_button_signal(BUTTON_CALL_DOWN, floor))
			{
				elev_set_button_lamp(BUTTON_CALL_DOWN, floor, 1);
				if (order_buttons[floor][0] != 1)
				{
					order_buttons[floor][0] = 1;
					order_amount++;
				}
			}
		}
	}
}


int get_order(int floor, int button)
{
	return order_buttons[floor][button];
}

int get_order_amount(){
	return order_amount;
}

void reset_order(int floor)
{
	int floor_order_amount = 0;
	for (int i = 0; i<=2;i++)
	{
		if(order_buttons[floor][i] ==1)
		{
			floor_order_amount++;
			order_buttons[floor][i] = 0;
		}
	}
	elev_set_button_lamp(BUTTON_COMMAND, floor, 0);
	if(floor != 0)
	{
		elev_set_button_lamp(BUTTON_CALL_DOWN, floor,0);
	}
	if (floor != N_FLOORS-1)
	{
		elev_set_button_lamp(BUTTON_CALL_UP, floor, 0);
	}
	order_amount = order_amount - floor_order_amount;
	}


int order_is_in_dir()
{
	if (direction == 1) //Elevator is going up
	{
		for (int floor = current_floor + 1; floor < N_FLOORS; floor++) // Checking floors upwards from current floor
		{
			for (int button = 0; button < 3; button++)
			{
				if (get_order(floor, button))
				{
				return 1;
				}
			}
		}
	}
	else if (direction == -1) // Elevator going down
	{
		for (int floor = current_floor - 1; floor >= 0; floor--) // Checking floors downwards from current floor
		{
			for (int button = 0; button < 3; button++)
			{
				if (get_order(floor, button))
				{
				return 1;
				}
			}
		}
	}
	return 0;
}

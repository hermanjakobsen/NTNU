#include "control.h"
#include "elev.h"
#include "timer.h"
#include <stdio.h>


int main() {

    printf("Press obstruction button to stop elevator and exit program.\n");


	current_state = INITIALIZE;

    while (current_state != FAILURE)
    {
      current_state = state_machine(current_state);
      if(elev_get_obstruction_signal())   // Stop elevator and exit program if the obstruction button is pressed
      {
        elev_set_motor_direction(DIRN_STOP);
        break;
      }
    }
    if (current_state == FAILURE)
    {
      return 1;
    }
    return 0;
}

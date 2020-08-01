#include "elev.h"
#include <stdio.h>

// **** Contains miscellaneous functions and variables ****

// These variables are used in functions throughout different files

int direction;
int current_floor;

// These two variables are only used when the elevator is "stuck" between two floors
int last_direction;
int floor_reached;

// Opens door
void open_door(void);

// Closes door
void close_door(void);

// Stops the elevator
void stop_elev();

// Stops the elevator, illuminates the stop light and resets orders
void set_EM_stop();

//Sets the floor lights and current_floor
void set_floor_and_light();

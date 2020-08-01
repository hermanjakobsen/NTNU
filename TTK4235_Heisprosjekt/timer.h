#include <time.h>
#include <stdio.h>

// **** Contains functions for the timer ****

time_t start_value;
time_t end_value;

// Starts the timer
void start_timer();

// Checks if time seconds have past
// @return 1 if time seconds have past, return 0 otherwise
int check_timer(double seconds);

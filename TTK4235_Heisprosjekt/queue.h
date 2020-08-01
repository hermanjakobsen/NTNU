#include "elev.h"
#include "utilities.h"
#include <stdio.h>


// **** Functions for handling orders ****

// Sets an order and illuminates button
void set_order();

// Returns amount of orders
int get_order_amount();

// Resets the order given
void reset_order(int floor);

// Checks in order_buttons for orders
// @return 1 if the floor and button is ordered, 0 otherwise
int get_order(int floor, int button);

// Checks if an order is in the current direction
// @return 1 if an order exists, 0 otherwise
int order_is_in_dir();

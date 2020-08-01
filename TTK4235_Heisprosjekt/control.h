

// **** Contains functions and variables for the state machine ****

enum state {INITIALIZE,
			EMERGENCY_BRAKE,
			FAILURE,
			IDLE,
			EXECUTE_ORDER,
			TEST,
			STOP_ENABLED,
			ARRIVED};


// Variables
enum state next_state;
enum state current_state;

// The backbone: Switches between states and executes transition code
enum state state_machine(enum state current_state);

// Initializes hardware
// Exits the problem if an error occur
void initialize_hardware();

// Puts the elevator in a defined state
// (closest floor downwards with doors closed and correct floor lamp illuminated)
void initialize();

// Chooses the direction the elevator must initially move, and makes the elevator drive in that direction
// If an order is made at the floor the elevator is currently at, the elevator will stand still
void choose_direction();

//Checks if an order is complete
void check_if_order_is_complete();

// Deletes orders, opens door, etc...
void arrived_procedure();

// Stops the elevator, deletes all orders, opens door if at floor, etc...
void EM_stop_procedure();



#include "twi.h"
#include "ubit_led_matrix.h"
#include "gpio.h"
#include "utility.h"
#include "accel.h"

#include <stdlib.h>

int main(){

    for(int i = 4; i <= 15; i++){
		GPIO->DIRSET = (1 << i);
		GPIO->OUTCLR = (1 << i);
	}

    uint8_t accelerometer_address = 0x1D;
    uint8_t whoami_register = 0x0D;         //value 0x5A (=90 in 10-based)
    int registers_to_read = 2;
    uint8_t * data_buffer = (uint8_t *)malloc(8 * sizeof(uint8_t));

    twi_init();
    twi_multi_read(accelerometer_address, whoami_register, registers_to_read, data_buffer);

    if (data_buffer[0] == 90){
        GPIO->OUTSET = (1 << 13);
	    GPIO->OUTSET = (1 << 14);
        GPIO->OUTSET = (1 << 15);
    }
    free(data_buffer);
    accel_init();
    ubit_led_matrix_init();

    int accl_buffer[3];

    while(1){
        accel_read_x_y_z(accl_buffer);

        int x_acc = accl_buffer[0];
        int y_acc = accl_buffer[1];
        int z_acc = data_buffer[2];

        int x_dot = x_acc / 50;
        int y_dot = -y_acc / 50;

        ubit_led_matrix_light_only_at(x_dot, y_dot);

        int sleep = 1000000;
        while(--sleep);

    }
    return 0;
}

#include "twi.h"

void twi_init(){

    TWI0->PSELSCL = 0;              // Set SCL to pin 0
    TWI0->PSELSDA = 30;        // Set SDA to pin 30
    TWI0->ENABLE = 0x5;             // Enable TWI
    TWI0->FREQUENCY = 0x01980000;   // 100 kbps

}

void twi_multi_read(
            uint8_t slave_address,
            uint8_t start_register,
            int registers_to_read,
            uint8_t * data_buffer
        ){
            TWI0->ADDRESS = slave_address;
            TWI0->STARTTX = 1;

            TWI0->TXDSENT = 0;
            TWI0->TXD = start_register;

            while(!TWI0->TXDSENT){
                /* Wait for TXDSENT event */
            }
            TWI0->RXDREADY = 0;
            TWI0->STARTRX = 1;
            for  (int i = 0; i < registers_to_read - 1; i++){
                while (!TWI0->RXDREADY){
                    /* Wait for RXDREADY event */

                    
                }
                data_buffer[i] = TWI0->RXD;
                TWI0->RXDREADY = 0;
            }

            TWI0->STOP = 1;

            while (!TWI0->RXDREADY){
                /* Wait for RXDREADY event */
            }
            data_buffer[registers_to_read - 1] = TWI0->RXD;
            TWI0->RXDREADY = 0;

        }

void twi_multi_write(uint8_t slave_address,
            uint8_t start_register,
            int registers_to_read ,
            uint8_t * data_buffer
        ){
            TWI0->ADDRESS = slave_address;
            TWI0->STARTTX = 1;
            TWI0->TXDSENT = 0;
            for(int i = 0; i < registers_to_read; i++){
                TWI0->TXD = data_buffer[registers_to_read];
                while(!TWI0->TXDSENT){
                    /* Wait for event */
                }
                TWI0->TXDSENT = 0;
            }
            TWI0->STOP = 1;
        }

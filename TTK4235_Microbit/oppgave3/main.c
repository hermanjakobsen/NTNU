
#include "gpio.h"
#include "gpiote.h"
#include "ppi.h"

int main(){
    // Config LED-matrix
    for(int i = 4; i <= 12; i++){
        GPIO->DIRSET = (1 << i);
        GPIO->OUTCLR = (1 << i);
    }


    // Config GPIOTE-channels
    // Config A-button, pin 17, event, falling edge
    GPIOTE->CONFIG[0] = 0x00021101;

    // Config supply pins, task, toggle, 1 as initial value
    // Pin 13
    GPIOTE->CONFIG[1] = 0x00130D03;

    // Pin 14
    GPIOTE->CONFIG[2] = 0x00130E03;

    // Pin 15
    GPIOTE->CONFIG[3] = 0x00130F03;

    // Config the PPI-channels
    PPI->PPI_CH[0].EEP = (uint32_t)&(GPIOTE->IN[0]);
    PPI->PPI_CH[0].TEP = (uint32_t)&(GPIOTE->OUT[1]);

    PPI->PPI_CH[1].EEP = (uint32_t)&(GPIOTE->IN[0]);
    PPI->PPI_CH[1].TEP = (uint32_t)&(GPIOTE->OUT[2]);


    PPI->PPI_CH[2].EEP = (uint32_t)&(GPIOTE->IN[0]);
    PPI->PPI_CH[2].TEP = (uint32_t)&(GPIOTE->OUT[3]);

    PPI->CHENSET = 0x00000007; // Activate CH 0 - 2 (could also just write 0x7)


    // Keep the CPU busy
    while(1){
        /* Do Nothing */
    }

    return 0;
}

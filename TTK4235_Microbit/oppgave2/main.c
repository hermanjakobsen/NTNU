#include "uart.h"
#include "gpio.h"
#include <stdio.h>

ssize_t _write(int fd, const void *buf, size_t count){
	char * letter = (char *)(buf);
	for(int i = 0; i < count; i++){
		uart_send(*letter);
		letter++;
	}
	return count;
}


void toggle_leds(){

    // Hvis lys allerede er på
    if((GPIO->IN & (1<< 13)) != 0){
        GPIO->OUTCLR = (1 << 13);
        GPIO->OUTCLR = (1 << 14);
        GPIO->OUTCLR = (1 << 15);
    }

    else{
        GPIO->OUTSET = (1 << 13);
        GPIO->OUTSET = (1 << 14);
        GPIO->OUTSET = (1 << 15);
    }
}




int main(){

	uart_init();

	// Configure pins
	for(int i = 4; i <= 15; i++){
        GPIO->DIRSET = (1<<i);
        GPIO->OUTCLR = (1<<i);
    }

	GPIO->PIN_CNF[17] = 0; // A
	GPIO->PIN_CNF[26] = 0; // B

	int pinA = (1 << 17);
	int pinB = (1 << 26);

	iprintf("Norway has %d counties. \n\r", 18);


	while(1){

	    // Sjekker om knapp B er trykket inn
	    if((GPIO->IN & pinB) != pinB){ // Knappene er aktivt lave
	        uart_send('B');
	    }

	    //Sjekker om knapp A er trykket inn
	    if((GPIO->IN & pinA) != pinA){ //Knappene er aktivt lave
	        uart_send('A');
	    }

		if (uart_read() != '\0'){
			toggle_leds();
		}



	}
	return 0;
}

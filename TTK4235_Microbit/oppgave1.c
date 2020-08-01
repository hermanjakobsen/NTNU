#include <stdint.h>

#define GPIO ((NRF_GPIO_REGS*)0x50000000)

typedef struct {
	volatile uint32_t RESERVED0[321];
	volatile uint32_t OUT;
	volatile uint32_t OUTSET;
	volatile uint32_t OUTCLR;
	volatile uint32_t IN;
	volatile uint32_t DIR;
	volatile uint32_t DIRSET;
	volatile uint32_t DIRCLR;
	volatile uint32_t RESERVED1[120];
	volatile uint32_t PIN_CNF[32];
} NRF_GPIO_REGS;

int main(){
	// Configure LED Matrix
	// Pinnene blir satt til output, vi kan da skrive til pinnene. 
	// Pinnene blir initialisert til 0
	for(int i = 4; i <= 15; i++){
		GPIO->DIRSET = (1 << i);
		GPIO->OUTCLR = (1 << i);
	}

	// Configure buttons
	// Blir definert som input, kan altså lese verdien på pin 
	GPIO->PIN_CNF[17] = 0;
	GPIO->PIN_CNF[26] = 0;

	// int pinA = 0b0000 0000 0000 0001 0000 0000 0000 0000; Kan representeres som 	(1 << 17)
	// int pinB = 0b0000 0010 0000 0000 0000 0000 0000 0000; 						(1 << 26)
	// siden C ikke støtter binære tall

	int pinA = (1 << 17);
	int pinB = (1 << 26);

	int sleep = 0;
	while(1){

		/* Check if button B is pressed;
		 * turn on LED matrix if it is. */
		if((GPIO->IN & pinB) != pinB) {
			GPIO->OUTSET = (1 << 13);
			GPIO->OUTSET = (1 << 14);
			GPIO->OUTSET = (1 << 15);
		}

		/* Check if button A is pressed;
		 * turn off LED matrix if it is. */
		else if ((GPIO->IN & pinA) != pinA){
				GPIO->OUTCLR = (1 << 13);
				GPIO->OUTCLR = (1 << 14);
				GPIO->OUTCLR = (1 << 15);
		}

		sleep = 10000;
		while(--sleep);
	}
	return 0;
}

// Svar på spørsmål:
// Button A er koblet til Pin 17 (P0.17)
// Button B er koblet til pin 26 (P0.26)
// Pinnene vil være lav hvis knappene trykkes inn
// Baseadressen til GPIO-modulen er 0x50000000
// Reserved_1 skal dekke minnerommet 0x520 -> 0x700
// Altså er størrelsen på 0x700 - 0x520 = 0x1E0 bytes
// Det tilsvarer 480 bytes
// En ordstørrelse på 4 byte brukes, så størrelsen på
// Reserved_1 er 480 / 4 = 120



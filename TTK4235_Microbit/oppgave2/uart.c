#include <stdint.h>
#include "gpio.h"

#define UART ((NRF_UART_REG*)0x40002000)

typedef struct{
  // Tasks
  volatile uint32_t STARTRX;
  volatile uint32_t STOPRX;
  volatile uint32_t STARTTX;
  volatile uint32_t STOPTX;
  volatile uint32_t RESERVED2[3];
  volatile uint32_t SUSPEND;
  volatile uint32_t RESERVED3[56];

  // Events
  volatile uint32_t CTS;
  volatile uint32_t NCTS;
  volatile uint32_t RXDRDY;
  volatile uint32_t RESERVED4[4];
  volatile uint32_t TXDRDY;
  volatile uint32_t RESERVED5[1];
  volatile uint32_t ERROR;
  volatile uint32_t RESERVED6[7];
  volatile uint32_t RXTO;
  volatile uint32_t RESERVED7[110];

  // Registers
  volatile uint32_t INTEN;
  volatile uint32_t INTENSET;
  volatile uint32_t INTENCLR;
  volatile uint32_t RESERVED8[93];
  volatile uint32_t ERRORSRC;
  volatile uint32_t RESERVED9[31];
  volatile uint32_t ENABLE;
  volatile uint32_t RESERVED10[1];
  volatile uint32_t PSELRTS;
  volatile uint32_t PSELTXD;
  volatile uint32_t PSELCTS;
  volatile uint32_t PSELRXD;
  volatile uint32_t RXD;
  volatile uint32_t TXD;
  volatile uint32_t RESERVED11[1];
  volatile uint32_t BAUDRATE;
  volatile uint32_t RESERVED12[17];

} NRF_UART_REG;

void uart_init(){

  UART->PSELTXD = 24;
  UART->PSELRXD = 25;

  UART->BAUDRATE = 2576384; // Tilsvarer 0X00275000

  UART->NCTS = 1;
  UART->PSELRTS = 4294967295; // Tilsvarer 0xFFFFFFFF
  UART->PSELCTS = 4294967295; // Tilsvarer 0xFFFFFFFF

  UART->ENABLE = 4;

  UART->STARTRX = 1;
}

void uart_send(char letter){
  UART->STARTTX = 1;
  UART->TXDRDY = 0;
  UART->TXD = letter;
  while(!UART->TXDRDY){
    /* Do nothing */
  }
  UART->STOPTX = 1;
}

char uart_read(){
  if (!UART->RXDRDY){
    return '\0';
  }

  UART->RXDRDY = 0;
  char letter = UART->RXD;
  return letter;
}

/*
*****************************************************************************
**
**  File        : stm32_flash_f722.ld
**
**  Abstract    : Linker script for STM32F722RETx Device with
**                512KByte FLASH, 256KByte RAM
**
*****************************************************************************
*/

/* Stack & Heap sizes */
_Min_Heap_Size = 0;
_Min_Stack_Size = 0x1800;

/* Entry Point */
ENTRY(Reset_Handler)

/*
0x08000000 to 0x0807FFFF  512K full flash,
0x08000000 to 0x08003FFF   16K isr vector, startup code,
0x08004000 to 0x08007FFF   16K config,                  // FLASH_Sector_1
0x08008000 to 0x0807FFFF  480K firmware,
*/

/* Specify the memory areas */
MEMORY
{
    ITCM_RAM (rwx)           : ORIGIN = 0x00000000, LENGTH = 16K

    /*ITCM_FLASH (rx)         : ORIGIN = 0x00200000, LENGTH = 16K*/
    /* config occupies the entire flash sector 1 for the ease of erasure, 16K on F72x */
    /*ITCM_FLASH_CONFIG (r)   : ORIGIN = 0x00204000, LENGTH = 16K*/
    /*ITCM_FLASH1 (rx)        : ORIGIN = 0x00208000, LENGTH = 480K*/

    FLASH (rx)         : ORIGIN = 0x08008000, LENGTH = 16K
    FLASH_CONFIG (r)   : ORIGIN = 0x0800c000, LENGTH = 16K
    FLASH1 (rx)        : ORIGIN = 0x08010000, LENGTH = 448K

    TCM (rwx)          : ORIGIN = 0x20000000, LENGTH = 64K
    RAM (rwx)          : ORIGIN = 0x20010000, LENGTH = 192K
    MEMORY_B1 (rx)     : ORIGIN = 0x60000000, LENGTH = 0K
}

REGION_ALIAS("STACKRAM", TCM)
REGION_ALIAS("FASTRAM", TCM)

__firmware_start = ORIGIN(FLASH);

INCLUDE "stm32_flash_f7_split.ld"

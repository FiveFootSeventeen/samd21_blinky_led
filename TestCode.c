#include <samd.h>

void delay(int n)
{
    int i;

    for (;n >0; n--)
    {
        for (i=0;i<100;i++)
            __asm("nop");
    }
}

int main()
{
    REG_PORT_DIR0 |= (1<<28);

    while(1)
    {
        REG_PORT_OUT0 &= ~(1<<28);
        delay(200);
        REG_PORT_OUT0 |= (1<<28);
        delay(100);
        REG_PORT_OUT0 &= ~(1<<28);
        delay(200);
        REG_PORT_OUT0 |= (1<<28);
        delay(1000);
    }
}

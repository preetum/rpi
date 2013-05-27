extern void ledON();
extern void ledOFF();
extern void wait(int);

void wait1sec()
{
    wait(0xf4240);
}
void waitShort()
{
	wait(0x30000);
}
int main()
{
    for(int i = 0; i < 10; i++)
    {
        ledON();
        waitShort();
        ledOFF();
        waitShort();
    }
}

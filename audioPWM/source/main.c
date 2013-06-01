extern void ledON();
extern void ledOFF();
extern void wait(int); /* in uS */
extern void spin();

extern void initPWM40();
extern void initPWMclk();
extern void setPWM1(int dat, int rng);
extern void clearPWM1();

/* returns [0, 1024] for x in range [0, 512], over period [0, pi] */
int _sin(int x)
{
	return ((x << 9) - x*x) >> 6;
}
int sin(int x)
{
	if(x > 512)
		return 0 - _sin(x - 512);
	else
		return _sin(x);
}

int main()
{
	initPWM40();
	initPWMclk();


	while(1)
	{
		for(int x = 0; x < 1024; x++)
		{
			int pwm = (sin(x) + 1024) >> 1;
			setPWM1(pwm, 1024);

			for(int k = 0; k < 50/8; k++)
				spin();
			//wait(16); //want 128 cycles in ~2270uS for 440Hz. so ~16uS per cycle.
		}
	}
}

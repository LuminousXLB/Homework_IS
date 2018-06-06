# include "stdio.h"

int main()
{
	short x = 0x0001;
	char *p = (char *) &x;
	if(*p) {
		printf("big endian\n");
	} else {
		printf("little endian\n");
	}

	return 0;
}

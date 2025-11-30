

#include<stdio.h>

void main()
{
	int c;
	int i;
	int pos = 0;
	int goodies = 0;
	char output[10];
	for (i=0; i<10; i++) {
		output[i] = 0;
	}

	while ((c = getchar() ) != EOF) {
		if (c == 62 ) {
			goodies = 1;
		} else if ( goodies > 0 ) {
			if (c == 38) {
				goodies = 0;
			} else {
				output[pos] = c;
				pos++;
			}
		}
		else {
			goodies = 0;
		}
	}

	printf("%s", output);
}




#include <stdio.h>
#include <unistd.h>
int main(int ac, char **argv)
{
	if (ac != 2)
		return (0);
	int i = -1;
	while (argv[1][++i])
		argv[1][i] -= i;
	printf("Flag09 password : %s\n", argv[1]);
	return (1);
}

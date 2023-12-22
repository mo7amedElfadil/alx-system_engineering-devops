#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
/**
 * infinite_while - infinite while loop
 * Return: Always 0 (Success)
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - Entry point
 *
 * Return: Always 0 (Success)
 */
int main(void)
{
	int i;

	for (i = 0; i < 5; i++)
	{
		if (fork() == 0)
		{
			printf("Zombie process created, PID: %i\n", getpid());
			exit(EXIT_SUCCESS);
		}
	}
	infinite_while();

	return (0);
}

/**
 * written by Gabriel de Oliveira Leme <https://github.com/gabrielleme00>
 * https://gist.github.com/gabrielleme00/b4cd86a8e148b1a20af13b6c6029ef66
 */
#include <iostream>

unsigned char tape[30000] = {0};
unsigned char* ptr = tape;

void interpret(char* input)
{
	char current_char;
	unsigned int i, loop;
	
	for (i = 0; input[i] != 0; ++i)
	{
		current_char = input[i];

		switch (current_char)
		{
			case '>':
				++ptr;
				break;
			case '<':
				--ptr;
				break;
			case '+':
				++*ptr;
				break;
			case '-':
				--*ptr;
				break;
			case '.':
				putchar(*ptr);
				break;
			case ',':
				*ptr = getchar();
				break;
			case '[':
				if (*ptr == 0)
				{
					loop = 1;
					while (loop > 0)
					{
						current_char = input[++i];
						if (current_char == '[')
							loop++;
						else if (current_char == ']')
							loop--;
					}
				}
				break;
			case ']':
				if (*ptr)
				{
					loop = 1;
					while (loop > 0)
					{
						current_char = input[--i];
						if (current_char == '[')
							loop--;
						else if (current_char == ']')
							loop++;
					}
				}
		}
	}
}

int main()
{

	char str[1024];
	std::cin.get(str, 1024);
	
	interpret(str);
	putchar('\n');

	return 0;
}

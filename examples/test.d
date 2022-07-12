import std.stdio;
int factorial(int num, int acc)
{
if(num <= 1)
{
return acc;
}
return factorial(num - 1, acc * num);
}

int main(string[] args)
{
writeln(factorial(10, 1));
return 0;
}


import std.stdio;
int main(string[] args)
{
if(args.length > 1)
{
writeln(args[1]);
}
else
{
for(int i = 0;i < 5;i++)
{
writeln(args[0]);
}
}
return 0;
}


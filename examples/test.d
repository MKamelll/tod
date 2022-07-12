import std.stdio;
int main(string[] args)
{
if(args.length > 1)
{
writeln(args[1]);
}
else
{
writeln(args[0]);
}
return 0;
}


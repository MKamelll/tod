import std.stdio;
int main(string[] args)
{
if(args.length > 1)
{
writeln(args[1]);
}
else
{
int i = 0;
while(i < 10)
{
writeln(args[0]);
i++;}
}
return 0;
}


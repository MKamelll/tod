module tod;

import std.stdio;
import transpiler;

void main()
{
	string output = "test";
	auto transpiler = new Transpiler(output);
	transpiler.importStd("stdio")
			  .functionInit("int", "main")
			  .paramsInit()
			  .paramsAdd("string[]", "args")
			  .paramsEnd()
			  .blockInit()
			  
			  .functionCallInit("writeln")
			  .argsInit()
			  .argsAdd("args[0]")
			  .argsEnd()
			  .functionCallEnd()
			  
			  .functionReturn("0")
			  .blockEnd()
			  .functionEnd();
	
	transpiler.writeProgram("examples");
}

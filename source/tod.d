module tod;

import std.stdio;
import program;
import transpiler;

void main()
{
	auto checkArgs = new Program();
	checkArgs
	.ifInit()		  
	
	.ifConditionAdd("args.length > 1")
	
	.ifEnd()
	
	.blockInit()
	.functionCallInit("writeln")
	.argsInit()
	.argsAdd("args[1]")
	.argsEnd()
	.functionCallEnd()
	.blockEnd()
	
	.elseInit()

	.blockInit()
	.functionCallInit("writeln")
	.argsInit()
	.argsAdd("args[0]")
	.argsEnd()
	.functionCallEnd()
	.blockEnd()

	.elseEnd();
	
	////////////////////////////////////////////////////////////////////
	
	auto mainProgram = new Program();
	mainProgram
	.importStd("stdio")
	.functionInit("int", "main")
	.paramsInit()
	.paramsAdd("string[]", "args")
	.paramsEnd()
	.blockInit()
	.join(checkArgs)
	.functionReturn("0")
	.blockEnd()
	.functionEnd();

	/////////////////////////////////////////////////////////////////
	auto output = "test";
	auto t = new Transpiler(output, mainProgram);
	
	t.write("examples");
}

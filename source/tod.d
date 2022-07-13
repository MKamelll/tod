module tod;

import std.stdio;
import program;
import transpiler;
import std.typecons;

void main()
{

    auto node = new Program();
    node
    .structInit("Node")
    .structEnd()
    .blockInit()
    .decl("string", "mDate")
    .decl("Node * ", "mNext")
    .blockEnd();
    
    ////////////(ex2)///////////////
    auto factorial = new Program();
    factorial
    .functionInit("int", "factorial")
    .paramsInit()
    .paramsAdd("int", "num")
    .paramsAdd("int", "acc")
    .paramsEnd()
    .blockInit()
    
    .ifInit()
    .ifConditionAdd("num <= 1")
    .ifEnd()
    
    .blockInit()
    .functionReturnInit()
    .identifier("acc")
    .functionReturnEnd()
    .blockEnd()

    .functionReturnInit()
    .functionCallInit("factorial")
    .argsInit()
    .argsAdd("num - 1")
    .argsAdd("acc * num")
    .argsEnd()
    .functionCallEnd()
    .functionReturnEnd()

    .blockEnd()
    .functionEnd();

    ////////////(ex1)//////////////
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
    
    .def("int", "i", "0")
    .whileInit()
    .whileCondition("i < 10")
    .whileEnd()
    
    .blockInit()
    .functionCallInit("writeln")
    .argsInit()
    .argsAdd("args[0]")
    .argsEnd()
    .functionCallEnd(Yes.terminate)
    .suffix("i", "++", Yes.terminate)
    .blockEnd()
    
    .blockEnd()

    .elseEnd();
    
    ////////////////////////////////////////////////////////////////////
    
    auto mainProgram = new Program();
    mainProgram
    .importStd("stdio")
    .join(node)
    .join(factorial)
    .functionInit("int", "main")
    .paramsInit()
    .paramsAdd("string[]", "args")
    .paramsEnd()
    .blockInit()
    .functionCallInit("writeln")
    .argsInit()
    .functionCallInit("factorial")
    .argsInit()
    .argsAdd("10")
    .argsAdd("1")
    .argsEnd()
    .functionCallEnd()
    .argsEnd()
    .functionCallEnd(Yes.terminate)
    .functionReturnInit()
    .number("0")
    .functionReturnEnd()
    .blockEnd()
    .functionEnd();

    /////////////////////////////////////////////////////////////////
    auto output = "test";
    auto t = new Transpiler(output, mainProgram);
    
    t.write("examples");
}

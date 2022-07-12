module program;

class Program
{
    private string mProgram;
    private int mCurrArgsCount;
    private int mCurrParamsCount;
    private int mCurrFunCallDepth;
    
    this () {
        mCurrArgsCount = 0;
        mCurrParamsCount = 0;
        mCurrFunCallDepth = 0;
    }

    private void append(string str) {
        mProgram ~= str;
    }

    private void pop(int i) {
        mProgram = mProgram[0..$-i];
    }

    private void space(int count = 1) {
        for (int i = 0; i < count; i++) {
            mProgram ~= " ";
        }
    }

    private void eol() {
        mProgram ~= "\n";
    }

    private void semiColon() {
        mProgram ~= ";";
    }

    private int getArgsCount() {
        return mCurrArgsCount;
    }

    private void incArgsCount() {
        mCurrArgsCount += 1;
    }

    private void resetArgsCount() {
        mCurrArgsCount = 0;
    }

    private int getParamsCount() {
        return mCurrParamsCount;
    }

    private void incParamsCount() {
        mCurrParamsCount++;
    }

    private void resetParamsCount() {
        mCurrParamsCount = 0;
    }

    private int getCurrFunCallDepth() {
        return mCurrFunCallDepth;
    }

    private void incCurrFunCallDepth() {
        mCurrFunCallDepth++;
    }

    private void decCurrFunCallDepth() {
        mCurrFunCallDepth--;
    }

    private void resetCurrFunCallDepth() {
        mCurrFunCallDepth = 0;
    }

    Program join(Program rhs) {
        append(rhs.getProgram());
        return this;
    }

    string getProgram() {
        return mProgram;
    }

    Program opBinary(string op : "~")(Program rhs)
    {
        mProgram ~= rhs.getProgram();
        return this;
    }

    Program opOpAssign(string op)(Program rhs)
    {
        mProgram ~= rhs.getProgram();
        return this;
    }

    Program importStd(string name) {
        append("import");
        space();
        append("std");
        append(".");
        append(name);
        semiColon();
        eol();
        return this;
    }

    Program importFile(string name) {
        append("import");
        space();
        append(name);
        semiColon();
        eol();
        return this;
    }

    Program classDecl(string name) {
        classInit(name);
        semiColon();
        eol();
        return this;
    }

    Program classInit(string name) {
        append("class");
        space();
        append(name);
        return this;
    }

    Program classEnd() {
        eol();
        return this;
    }

    Program blockInit() {
        eol();
        append("{");
        eol();
        return this;
    }

    Program blockEnd() {
        append("}");
        eol();
        return this;
    }

    Program functionInit(string returnType, string name) {
        append(returnType);
        space();
        append(name);
        return this;
    }

    Program functionEnd() {
        eol();
        return this;
    }

    Program paramsInit() {
        append("(");
        return this;
    }

    Program paramsEnd() {
        if (getParamsCount() > 0) {
            pop(2);
        }
        append(")");
        return this;
    }

    Program paramsAdd(string type, string name) {
        incParamsCount();
        append(type);
        space();
        append(name);
        append(",");
        space();
        return this;
    }

    Program functionReturn(string value) {
        append("return");
        space();
        append(value);
        semiColon();
        eol();
        return this;
    }

    Program argsInit() {
        append("(");
        return this;
    }

    Program argsEnd() {
        if (getArgsCount() > 0) {
            pop(2);
        }
        append(")");
        resetArgsCount();
        return this;
    }

    Program argsAdd(string value) {
        incArgsCount();
        append(value);
        append(",");
        space();
        return this;
    }

    Program functionCallInit(string name) {
        incCurrFunCallDepth();
        append(name);
        return this;
    }

    Program functionCallEnd() {
        decCurrFunCallDepth();
        if (getCurrFunCallDepth() < 1) {
            semiColon();
            eol();
        }
        return this;
    }

    Program decl(string type, string name) {
        append(type);
        space();
        append(name);
        semiColon();
        eol();
        return this;
    }

    Program def(string type, string name, string expr) {
        append(type);
        space();
        append(name);
        space();
        append("=");
        space();
        append(expr);
        semiColon();
        eol();
        return this;
    }

    Program binary(string lhs, string op, string rhs) {
        append(lhs);
        space();
        append(op);
        space();
        append(rhs);
        return this;
    }

    Program number(string number) {
        append(number);
        space();
        return this;
    }

    Program identifier(string id) {
        append(id);
        space();
        return this;
    }

    Program ifInit() {
        append("if");
        append("(");
        return this;
    }

    Program ifEnd() {
        append(")");
        return this;
    }

    Program ifConditionAdd(string expr) {
        append(expr);
        return this;
    }

    Program elseIfInit() {
        append("else");
        ifInit();
        return this;
    }

    Program elseIfEnd() {
        ifEnd();
        return this;
    }

    Program elseInit() {
        append("else");
        return this;
    }

    Program elseEnd() {
        return this;
    }

    Program forInit() {
        append("for");
        append("(");
        return this;
    }

    Program forEnd() {
        append(")");
        return this;
    }

    Program forIndex(string type, string name, string value) {
        def(type, name, value);
        pop(2);
        semiColon();
        return this;
    }

    Program forCondition(string expr) {
        append(expr);
        semiColon();
        return this;
    }

    Program forAdvance(string expr) {
        append(expr);
        return this;
    }
}
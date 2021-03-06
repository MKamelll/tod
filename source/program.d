module program;

import std.typecons;

alias TerminateFlag = Flag!"terminate";

class Program
{
    private string mProgram;
    private int mCurrArgsCount;
    private int mCurrParamsCount;

    this () {
        mCurrArgsCount = 0;
        mCurrParamsCount = 0;
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
        return this;
    }

    Program structInit(string name) {
        append("struct");
        space();
        append(name);
        return this;
    }

    Program structEnd() {
        return this;
    }

    Program newInit(TerminateFlag terminate = No.terminate) {
        append("new");
        space();
        if (terminate) semiColon();
        return this;
    }

    Program newEnd() {
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

    Program functionReturnInit() {
        append("return");
        space();
        return this;
    }

    Program functionReturnEnd() {
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
        append(name);
        return this;
    }

    Program functionCallEnd(TerminateFlag terminate = No.terminate) {
        if (terminate) {
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

    Program binary(string lhs, string op, string rhs, TerminateFlag terminate = No.terminate) {
        append(lhs);
        space();
        append(op);
        space();
        append(rhs);
        if (terminate) semiColon();
        return this;
    }

    Program number(string number, TerminateFlag terminate = No.terminate) {
        append(number);
        if (terminate) semiColon();
        return this;
    }

    Program identifier(string id, TerminateFlag terminate = No.terminate) {
        append(id);
        if (terminate) semiColon();
        return this;
    }

    Program prefix(string op, string primary, TerminateFlag terminate = No.terminate) {
        append(op);
        append(primary);
        if (terminate) semiColon();
        return this;
    }

    Program suffix(string primary, string op, TerminateFlag terminate = No.terminate) {
        append(primary);
        append(op);
        if (terminate) semiColon();
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

    Program whileInit() {
        append("while");
        append("(");
        return this;
    }

    Program whileEnd() {
        append(")");
        return this;
    }

    Program whileCondition(string expr) {
        append(expr);
        return this;
    }
}
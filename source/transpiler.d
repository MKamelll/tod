module transpiler;

import std.file;
import std.stdio;

class Transpiler
{
    private string mName;
    private string mProgram;
    private int mCurrArgsCount;
    private int mCurrParamsCount;
    private int mCurrFunCallDepth;
    
    this (string name) {
        mName = name ~ ".d";
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

    Transpiler importStd(string name) {
        append("import");
        space();
        append("std");
        append(".");
        append(name);
        semiColon();
        eol();
        return this;
    }

    Transpiler importFile(string name) {
        append("import");
        space();
        append(name);
        semiColon();
        eol();
        return this;
    }

    Transpiler classDecl(string name) {
        classInit(name);
        semiColon();
        eol();
        return this;
    }

    Transpiler classInit(string name) {
        append("class");
        space();
        append(name);
        return this;
    }

    Transpiler classEnd() {
        eol();
        return this;
    }

    Transpiler blockInit() {
        eol();
        append("{");
        eol();
        return this;
    }

    Transpiler blockEnd() {
        append("}");
        eol();
        return this;
    }

    Transpiler functionInit(string returnType, string name) {
        append(returnType);
        space();
        append(name);
        return this;
    }

    Transpiler functionEnd() {
        eol();
        return this;
    }

    Transpiler paramsInit() {
        append("(");
        return this;
    }

    Transpiler paramsEnd() {
        if (getParamsCount() > 0) {
            pop(2);
        }
        append(")");
        return this;
    }

    Transpiler paramsAdd(string type, string name) {
        incParamsCount();
        append(type);
        space();
        append(name);
        append(",");
        space();
        return this;
    }

    Transpiler functionReturn(string value) {
        append("return");
        space();
        append(value);
        semiColon();
        eol();
        return this;
    }

    Transpiler argsInit() {
        append("(");
        return this;
    }

    Transpiler argsEnd() {
        if (getArgsCount() > 0) {
            pop(2);
        }
        append(")");
        resetArgsCount();
        return this;
    }

    Transpiler argsAdd(string value) {
        incArgsCount();
        append(value);
        append(",");
        space();
        return this;
    }

    Transpiler functionCallInit(string name) {
        incCurrFunCallDepth();
        append(name);
        return this;
    }

    Transpiler functionCallEnd() {
        decCurrFunCallDepth();
        if (getCurrFunCallDepth() < 1) {
            semiColon();
            eol();
        }
        return this;
    }

    Transpiler decl(string type, string name) {
        append(type);
        space();
        append(name);
        semiColon();
        eol();
        return this;
    }

    Transpiler def(string type, string name, string expr) {
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

    Transpiler binaryExpr(string lhs, string op, string rhs) {
        append(lhs);
        space();
        append(op);
        space();
        append(rhs);
        return this;
    }

    Transpiler primaryExpr(string expr) {
        append(expr);
        space();
        return this;
    }

    string getProgram() {
        return mProgram;
    }

    string getOutputFile() {
        return mName;
    }

    void writeProgram(string folderPath = "") {
        if (folderPath[$-1] != '/') {
            folderPath ~= "/";
        }
        
        auto file = File(folderPath ~ mName, "w");
        file.write(getProgram());
        file.close();
    }
}
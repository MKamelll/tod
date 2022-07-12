module transpiler;

import std.file;
import std.stdio;
import program;

class Transpiler
{
    string mName;
    Program mProgram;

    this (string name, Program program) {
        mName = name ~ ".d";
        mProgram = program;
    }

    string getOutputFile() {
        return mName;
    }

    void write(string folderPath = "") {
        if (folderPath[$-1] != '/') {
            folderPath ~= "/";
        }
        
        auto file = File(folderPath ~ mName, "w");
        file.write(mProgram.getProgram());
        file.close();
    }
}
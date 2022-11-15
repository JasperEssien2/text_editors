/* 
The include statement is similar to Dart import statement. We are importing neccessary
libraries to aid us in our task.
*/
#include <sstream>
#include <iostream>
#include <fstream>
using namespace std;

/*
The FFI library can only mind C symbols. We must mark code written with C++ with extern "C". 

C++ language supports funtion overloading, during compilation the compiler does 
"name mangling", altering function names to add extra information to overloaded functions.

C language does not support overloading, therefore the extern "C" tells compiler not to mangle function names.

The linker during compilation performs optimization by eliminates functions that appears to not be referenced. By adding the attributes we prevent this from happening, since we are referencing this function directly from Dart.
*/
extern "C" __attribute__((visibility("default"))) __attribute__((used))

bool createTextFile(char *fileName, char *content){
    try
    {
        // Get the home path
        const char *homeDir = getenv("HOME");
        
        // Concatenates the path with file name andextension
        std::ostringstream oss;
        oss <<  homeDir << "/" << fileName << ".txt";
        std::string filePath = oss.str();
        
        //Logs the file name and path to console
        cout << "fileName: " << fileName << " PATH: " << filePath << endl;

        std::ofstream myFile;

        //Open a file stream
        myFile.open(filePath);

        // Write content to the file
        myFile << content;

        // Close the file stream
        myFile.close();

        // return true to indicate file saved successfully
        return true;
    }
    catch(...)
    {
        //Log errors in console
        std::cerr << "An error occurred" << '\n';

        // Return false to indicate saving file failed
        return false;
    }   
}
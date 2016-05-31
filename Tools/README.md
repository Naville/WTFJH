#Tools

##ClangPlugin

**WIP**

This is a Plugin for Clang That, When Supported A Header, Automatically Generates a Module For It.
Core is complete(hopefully bug-free), although more transform rules needs to be applied into `WrapperGenerator()` of WTFJH.cpp
###Usage
1.	Rename the folder into `WTFJH`
2.	Put it inside `/PATH/TO/LLVM/SRC/tools/clang/examples`
3.	Add `add_subdirectory(WTFJH)` To The End Of `/PATH/TO/LLVM/SRC/tools/clang/examples/CMakeLists.txt`
4.	Re-run CMake

###Todo
1.	~~Add Generators for properties of a ObjC Class.~~ Done!
2.	~~Add Support For C Functions~~ Not gonna happen. Finding a place to insert the MSHookXXX() codes would be pain-in-ass

###Issues
1. All char* are treated as NSString. Cuz length is unknown
2. Type Support is far from complete
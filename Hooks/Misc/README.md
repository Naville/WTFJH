removePIE
=========
This is an iOS tool which flips the MH_PIE bit in an application. 
This disables the Address Space Layout Randomization of an application.

Building
========
Building has been set-up to use OS-X, xCode and the iOS 6.0 SDK in 
default directories. execute "make" from the command line to execute the included makefile.
This file includes the location of the iOS 6.0 SDK and the location of the ARM compiler of the SDK. The makefile also signs the compiled executable using the "codesign" tool provided by xCode.
Alterations will need to be made to the makefile for compiling on Windows or Linux systems.

Usage
=====
copy the compiled executable using scp i.e 
```bash
desktop $ scp ./removePIE root@<IP address of phone>:/usr/bin/removePIE
root \# ./removePIE <application binary>
```
The <application binary> is most likely located in a sub-directory of /private/var/mobile/Applications/ on the iphone 

Issues
======
Issues have been found with applications on ios 5.1.1, i have found that you have to resign the application binary using the "codesign" tool in xcode to get it to execute. i have no idea as yet to why ldone or ldid doesn't work. ios 6.0.1 did not require re-signing of the application binary.
'

License
=======

Copyright (c) 2013 Peter Fillmore

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

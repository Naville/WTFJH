# What The Fuck Just Happened
> A Modern Replacement For IntroSpy [iSECPartners/Introspy-iOS][1]
> Feel Free To Send Us Pull Requests. It's a project too big for two part-time developers
> Infrastructural Codes Are Copied (And Modified) From IntroSpy Project And My Own MinusBlock Project [Naville/MinusBlock][2] To Save Time.
> *VERSION* is meant to be there for package version consistency's sake

# Usage
> ./Template.py (SDK|API) ModuleName
for Generating a new Template
>Probably Need A substrate.h on device if you encounter compile errors
> ./build.py FOR BUILDING
- DEBUG For Displaying Building Logs
- PROTOTYPE For Enabling Prototype Codes

> Write Prototype Code Between *\#ifdef PROTOTYPE* and *\#endif*

> SignatureDatabase.plist is the code signature database we'll use to defeat Method/Name Obfuscations. Detailed Structs are to be determined

Read *Preferences/README.md* for more info

# TODOs
- Merge [https://github.com/BishopFox/iSpy][3] into WTFJH
- Merge [https://github.com/DavidGoldman/InspectiveC][4] into WTFJH
- Recognize Obfuscated Class/Func Based On Signatures And|Or Constants in *\_\_DATA*

[1]:	https://github.com/iSECPartners/Introspy-iOS
[2]:	https://github.com/Naville/MinusBlock
[3]:	https://github.com/BishopFox/iSpy "iSpy"
[4]:	https://github.com/DavidGoldman/InspectiveC "InspectiveC"

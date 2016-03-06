#ThirdParty Tools.
>As the saying goes. "Don't fix shit that ain't broken"
This folder contains third party tools that will be automatically compiled and binded inside the result Mach-O.

(You'll have to manually write a loader inside main codes.Check Hooks/ThirdPartyTools For Example)

Folder Name Is The Universal Identifier (This Also Works For Other Modules).So please make sure
>>FolderName==ProjectNameInMakeFile==Suffix Of Build dylib(That's the ProjectName in MakeFile)

##Warn
**ALL PROJECT NAMES MUST HAVE LENGTH SMALLER THAN 16**
>This is only for stuff that are nearly impossible to transfer into a pass of main project.
>For example. InspectiveC contains hacks within objc_msgSend that the main project heavily depends on.
>Therefor, it comes as a seperate Tool

#DON'T CALL MAIN PROJECT STUFF WITHIN PROJECTS HERE

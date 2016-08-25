#import "../SharedDefine.pch"
//Shall We Use Marcos instead of this shit?
#import "../SharedDefine.pch"
#import <mach-o/getsect.h>
#import <dlfcn.h>
extern NSString* RandomString();
typedef void (*CYListenServerPointer)(short);
extern void init_Cycript_hook(){
WTInit(@"WTFJH",@"LoadThirdPartyTools");//Global Tracer
#ifndef NonJailbroken
    void* Handle=dlopen("/usr/lib/libcycript.dylib",RTLD_GLOBAL);
#else
    NSString* BundledDYLIBPath=[NSString stringWithFormat:@"%@/libcycript.dylib",[NSBundle mainBundle].bundlePath];
    void*Handle=dlopen(BundledDYLIBPath.UTF8String,RTLD_NOW|RTLD_GLOBAL);

    [BundledDYLIBPath release];
#endif
    CYListenServerPointer FP=(CYListenServerPointer)dlsym(Handle,"CYListenServer");
	if(FP!=NULL){
#ifdef DEBUG
    NSLog(@"Starting Cycript");
#endif
        FP(CyPort);
        WTAdd([NSNumber numberWithInt:CyPort],@"CycriptPort");
	}
	else{
        char* Error=dlerror();

        if(Error!=NULL){
            WTAdd([NSString stringWithUTF8String:Error],@"CycriptStartError");
        }
	}
    dlclose(Handle);

    WTSave;
    WTRelease;
}
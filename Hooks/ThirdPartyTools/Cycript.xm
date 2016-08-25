#import "../SharedDefine.pch"
//Shall We Use Marcos instead of this shit?
#import "../SharedDefine.pch"
#import <mach-o/getsect.h>
#import <dlfcn.h>
typedef void (*CYListenServer)(short port);  
static CYListenServer CYListenServerFuncPointer;
extern NSString* RandomString();
typedef void (*WTLoaderPrototype)();  
extern void init_Cycript_hook(){
#ifndef NonJailbroken
//Because We Ain't Ready Yet. No Test
	 for(int i=0;i<_dyld_image_count();i++){
        const char * Nam=_dyld_get_image_name(i);
        NSString* curName=[NSString stringWithUTF8String:Nam];
        if([curName containsString:WTFJHTWEAKNAME]){
#ifdef DEBUG
            NSLog(@"Found Cycript At %i th Image",i);
#endif            
            intptr_t ASLROffset=_dyld_get_image_vmaddr_slide(i);
            //We Found Ourself
#ifndef __LP64__
            uint32_t size=0;
            const struct mach_header*   selfHeader=(const struct mach_header*)_dyld_get_image_header(i);
            char * data=getsectdatafromheader(selfHeader,"WTFJH","Cycript",&size);

#else
            uint64_t size=0;
            const struct mach_header_64*   selfHeader=(const struct mach_header_64*)_dyld_get_image_header(i);
            char * data=getsectdatafromheader_64(selfHeader,"WTFJH","Cycript",&size);
#endif
            data=ASLROffset+data;//Add ASLR Offset To Pointer And Fix Address
            NSData* SDData=[NSData dataWithBytes:data length:size];
            NSString* randomPath=[NSString stringWithFormat:@"%@/tmp/%@",NSHomeDirectory(),RandomString()];
            [SDData writeToFile:randomPath atomically:YES];
            void* handle=dlopen(randomPath.UTF8String,RTLD_NOW);//Open Created dylib
            WTLoaderPrototype WTHandle =(WTLoaderPrototype) dlsym(handle, "WTFJHInitCycript");  //Call Init Function
            if(WTHandle!=NULL){
            WTHandle();  
            }
            dlclose(handle);  
            [[NSFileManager defaultManager] removeItemAtPath:randomPath error:nil];
            //Inform Our Logger
            WTInit(@"WTFJH",@"LoadThirdPartyTools");
        	WTAdd(@"dlopen",@"Type");
        	WTAdd(randomPath,@"Path");
            WTAdd(@"Cycript",@"ModuleName");
            char* Err=dlerror();
            if(Err!=NULL){
                WTAdd([NSString stringWithUTF8String:Err],@"Error");
            }
        	WTSave;
        	WTRelease;
        	//End
            [SDData release];
            [randomPath release];

            [curName release];
            break;
        }
        [curName release];

    }
#else

NSString* BundledDYLIBPath=[NSString stringWithFormat:@"%@/libCycript.dylib",[NSBundle mainBundle].bundlePath];
dlopen(BundledDYLIBPath.UTF8String,RTLD_NOW);

[BundledDYLIBPath release];
#endif
void * Handle=dlopen(NULL,RTLD_NOW|RTLD_GLOBAL);
CYListenServerFuncPointer=(CYListenServer)dlsym(Handle,"_CYListenServer");
	dlclose(Handle);
	//Fuck Theos
	if(CYListenServerFuncPointer!=NULL){
    CYListenServerFuncPointer(CyPort);
    NSLog(@"Cycript Server At %i",CyPort);
	}
	else{
		NSLog(@"Cycript Failed To Start");
	}


}
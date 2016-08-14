#import "../SharedDefine.pch"
#import <dlfcn.h>
int (*old_dladdr)(const void *, Dl_info *);
void * (*old_dlsym)(void * __handle, const char * __symbol);
void * (*old_dlopen)(const char * __path, int __mode);
int new_dladdr(const void * addr, Dl_info * info){
    int ret = old_dladdr(addr, info);
    if (WTShouldLog) {
        WTInit(@"dlfcn",@"dladdr");
        if(info->dli_fname!=NULL){
             WTAdd([NSString stringWithUTF8String:info->dli_fname],@"PathOfObject");
        }
        else{
            WTAdd(@"NULL",@"PathOfObject");
        }
        if(info->dli_sname!=NULL){
             WTAdd([NSString stringWithUTF8String:info->dli_sname],@"NameOfNearestSymbol");
        }
        else{
            WTAdd(@"NULL",@"NameOfNearestSymbol");
        }
        WTSave;
        WTRelease;
    }
    return ret;
}
void * new_dlsym(void * handle, const char* symbol) {
	if (WTShouldLog) {
		WTInit(@"dlfcn",@"dlsym");
        if(symbol!=NULL){
            WTAdd([NSString stringWithUTF8String:symbol],@"Symbol");
        }

        WTAdd(objectTypeNotSupported,@"Handle");
        WTSave;
        WTRelease;
	}
	return old_dlsym(handle,symbol);

}
void * new_dlopen(const char * __path, int __mode) {
	if (WTShouldLog) {
		WTInit(@"dlfcn",@"dlopen");
        if(__path!=NULL){
            WTAdd([NSString stringWithUTF8String:__path],@"Path");
        }
        else{
            WTAdd(objectTypeNotSupported,@"Path");
        }
        WTAdd([NSNumber numberWithInt:__mode],@"Mode");
        WTSave;
        WTRelease;
	}
	return old_dlopen(__path,__mode);

}


extern void init_dlfcn_hook() {
    WTFishHookSymbols("dladdr",(void*)new_dladdr, (void**)&old_dladdr);
    WTFishHookSymbols("dlopen",(void*)new_dlopen, (void**)&old_dlopen);
    WTFishHookSymbols("dlsym",(void*)new_dlsym, (void**)&old_dlsym);
    /*WTHookFunction((void*)dladdr,(void*)new_dladdr, (void**)&old_dladdr);
    WTHookFunction((void*)dlsym,(void*)new_dlsym, (void**)&old_dlsym);
    WTHookFunction((void*)dlopen,(void*)new_dlopen, (void**)&old_dlopen);*/
}

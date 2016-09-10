#import "../SharedDefine.pch"
#import <mach-o/dyld.h>
#import <mach-o/loader.h>
#import <dlfcn.h>
#ifndef __LP64__
#define MHeader struct mach_header*
#else
#define MHeader struct mach_header_64*
#endif

//Extern Original Function Symbols
#ifdef PROTOTYPE
typedef int (*dladdr_pointer)(const void *, Dl_info *);
extern dladdr_pointer old_dladdr;
extern NSMutableDictionary* InfoFromDlInfo(Dl_info* info);



static NSMutableDictionary* InfoFromMachHeader(MHeader Header){
#ifdef DEBUG
	NSLog(@"dyldAPI---InfoFromMachHeader");
#endif

	NSMutableDictionary* RetDict=[NSMutableDictionary dictionary];
	[RetDict setObject:[NSNumber numberWithInt:Header->magic] forKey:@"magic"];
	[RetDict setObject:[NSNumber numberWithInt:Header->cputype] forKey:@"cputype"];
	[RetDict setObject:[NSNumber numberWithInt:Header->cpusubtype] forKey:@"cpusubtype"];
	[RetDict setObject:[NSNumber numberWithInt:Header->filetype] forKey:@"filetype"];
	[RetDict setObject:[NSNumber numberWithInt:Header->ncmds] forKey:@"ncmds"];
	[RetDict setObject:[NSNumber numberWithInt:Header->sizeofcmds] forKey:@"sizeofcmds"];
	[RetDict setObject:[NSNumber numberWithInt:Header->flags] forKey:@"flags"];
	return RetDict;
}

int (*old_dyld_image_count)(void);
MHeader (*old_dyld_get_image_header)(uint32_t image_index);
intptr_t (*old_dyld_get_image_vmaddr_slide)(uint32_t image_index);
const char* (*old_dyld_get_image_name)(uint32_t image_index);
void (*old_dyld_register_func_for_add_image)(void (*func)(const struct mach_header* mh, intptr_t vmaddr_slide));
void (*old_dyld_register_func_for_remove_image)(void (*func)(const struct mach_header* mh, intptr_t vmaddr_slide));


int new_dyld_image_count(){
	int ret=old_dyld_image_count();
	if (WTShouldLog) {
		WTInit(@"dyld",@"_dyld_image_count");
		WTReturn([NSNumber numberWithInt:ret]);
		WTSave;
		WTRelease;
	}
	return ret;

}
MHeader new_dyld_get_image_header(uint32_t image_index){
	MHeader retValue=old_dyld_get_image_header(image_index);
	if (WTShouldLog) {	
		WTInit(@"dyld",@"_dyld_get_image_header");
		WTAdd([NSNumber numberWithInt:image_index],@"ImageIndex");
		WTReturn(InfoFromMachHeader(retValue));
		WTSave;
		WTRelease;
	}
	return retValue;
}
intptr_t new_dyld_get_image_vmaddr_slide(uint32_t image_index){
	intptr_t retValue=old_dyld_get_image_vmaddr_slide(image_index);
	if (WTShouldLog) {
		WTInit(@"dyld",@"_dyld_get_image_vmaddr_slide");
		WTAdd([NSNumber numberWithInt:image_index],@"ImageIndex");
		WTReturn([NSNumber numberWithInteger:retValue]);
		WTSave;
		WTRelease;
	}
	return retValue;

}
const char* new_dyld_get_image_name(uint32_t image_index){
	const char* retValue=old_dyld_get_image_name(image_index);
	if (WTShouldLog) {
		WTInit(@"dyld",@"_dyld_get_image_name");
		WTAdd([NSNumber numberWithInt:image_index],@"ImageIndex");
		WTReturn([NSString stringWithUTF8String:retValue]);
		WTSave;
		WTRelease;
	}
	return retValue;

}
void new_dyld_register_func_for_add_image(void (*func)(const struct mach_header* mh, intptr_t vmaddr_slide)){
	if (WTShouldLog) {
		Dl_info DLINFO;
		old_dladdr(&func,&DLINFO);
		WTInit(@"dyld",@"_dyld_register_func_for_add_image");
		WTAdd(InfoFromDlInfo(&DLINFO),@"FunctionRegistered");
		WTSave;
		WTRelease;
	}
	old_dyld_register_func_for_add_image(func);

}
void new_dyld_register_func_for_remove_image(void (*func)(const struct mach_header* mh, intptr_t vmaddr_slide)){
	if (WTShouldLog) {
		WTInit(@"dyld",@"_dyld_register_func_for_remove_image");
		Dl_info DLINFO;
		old_dladdr(&func,&DLINFO);
		WTAdd(InfoFromDlInfo(&DLINFO),@"FunctionRegistered");
		WTSave;
		WTRelease;
	}
	old_dyld_register_func_for_remove_image(func);

}
#endif
extern void init_dyldAPI_hook() {
#ifdef PROTOTYPE
	if (old_dladdr==NULL){//Incase dlfcn is not switched on
		void* Handle=dlopen(NULL,RTLD_NOW|RTLD_GLOBAL);
		old_dladdr=(dladdr_pointer)dlsym(Handle,"dladdr");
		if(old_dladdr==NULL){
			old_dladdr=(dladdr_pointer)dlsym(Handle,"dladdr");
		}


	}
    WTFishHookSymbols("_dyld_image_count",(void*)new_dyld_image_count, (void**)&old_dyld_image_count);
    WTFishHookSymbols("_dyld_get_image_header",(void*)new_dyld_get_image_header, (void**)&old_dyld_get_image_header);
    WTFishHookSymbols("_dyld_get_image_vmaddr_slide",(void*)new_dyld_get_image_vmaddr_slide, (void**)&old_dyld_get_image_vmaddr_slide);
    WTFishHookSymbols("_dyld_get_image_name",(void*)new_dyld_get_image_name, (void**)&old_dyld_get_image_name);
    WTFishHookSymbols("_dyld_register_func_for_add_image",(void*)new_dyld_register_func_for_add_image, (void**)&old_dyld_register_func_for_add_image);
    WTFishHookSymbols("_dyld_register_func_for_remove_image",(void*)new_dyld_register_func_for_remove_image, (void**)&old_dyld_register_func_for_remove_image);

#endif



}

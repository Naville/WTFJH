//So We Can Intercept MSHookFunction Calls To C++/C Function
#import <Foundation/Foundation.h>
#import "WTSubstrate.h"
int WTHookFunction(void *symbol, void *replace, void **result){
#ifndef NonJailbroken	
	MSHookFunction(symbol,replace,result);
	return WTHookOK;
#else
	Dl_info Info;
	dladdr(symbol,&Info);
	const char* SymbolName=Info.dli_sname;
	return rebind_symbols((struct rebinding[1]){{SymbolName, replace,result}}, 1);

#endif

}
void * WTFindSymbol(WTImageRef image, const char *name){
#ifndef NonJailbroken	
	return MSFindSymbol(image,name);
#else
	if(image!=NULL){
		return dlsym(image,name);
	}
	else{
		void* Handle=dlopen(NULL,RTLD_LAZY|RTLD_NOW);
		return dlsym(Handle,name);
	}
#endif


}
int WTFishHookSymbols(const char* symbol,void *replace, void **result){

return rebind_symbols((struct rebinding[1]){{symbol, replace,result}}, 1);

}

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
	
	return dlsym(image,name);
#endif


}
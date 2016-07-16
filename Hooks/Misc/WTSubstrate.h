#import <substrate.h>
#import <dlfcn.h>
#import "fishhook.h"

#ifdef NonJailbroken
typedef void* WTImageRef;
#else
typedef MSImageRef WTImageRef;
#endif


int WTHookFunction(void *symbol, void *replace, void **result);
void * WTFindSymbol(WTImageRef image, const char *name);

#define WTHookOK 0

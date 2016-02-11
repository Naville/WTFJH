
#include <substrate.h>
#include <Security/Security.h>
#import "../Utils/SQLiteStorage.h"
#import "../Utils/PlistObjectConverter.h"
#import "../Utils/CallStackInspector.h"
#import "../SharedDefine.pch"


// Public Crypto Hook
// Hook SecPKCS12Import() - If the app uses a client cert
static OSStatus (*original_SecPKCS12Import)(CFDataRef pkcs12_data, CFDictionaryRef options, CFArrayRef *items);

static OSStatus replaced_SecPKCS12Import(CFDataRef pkcs12_data, CFDictionaryRef options, CFArrayRef *items) {
    OSStatus origResult = original_SecPKCS12Import(pkcs12_data, options, items);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"C" andMethod:@"SecPKCS12Import"];
    [tracer addArgFromPlistObject:(NSData*)pkcs12_data withKey:@"pkcs12_data"];
    [tracer addArgFromPlistObject:(NSDictionary*)options withKey:@"options"];
    [tracer addReturnValueFromPlistObject: [NSNumber numberWithInt:origResult]];
    [traceStorage saveTracedCall: tracer];
    [tracer release];  
    return original_SecPKCS12Import(pkcs12_data, options, items);
}


extern void init_Security_hook(){
    MSHookFunction((void *) SecPKCS12Import,(void *)  replaced_SecPKCS12Import, (void **) &original_SecPKCS12Import);
}


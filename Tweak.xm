#import "./Hooks/Global.h" 
#include <unistd.h>
#include <stdio.h>
static NSUncaughtExceptionHandler* OriginalExceptionHandler;
int RedirectedSTDOUT=0;
int RedirectedSTDERR=0;
static NSMutableDictionary* GlobalConfig=nil;
static BOOL RedirectLog(){
    NSDate *Date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *currentDate=[dateFormatter stringFromDate:Date];
    [dateFormatter release];
    [Date release];
    NSString* fileName=[NSString stringWithFormat:@"%@/Library/%@-%@.txt",NSHomeDirectory(),currentDate,[[NSProcessInfo processInfo] processName]];
    [@"-----Overture-----\n" writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    FILE *stdoutHandle=freopen(fileName.UTF8String,"w",stdout);
    FILE *stderrHandle=freopen(fileName.UTF8String,"w",stderr);
    if(stdoutHandle!=NULL && stderrHandle!=NULL){
        return YES;
    }
    else{
        return NO;
    }
}
void UncaughtExceptionHandler(NSException *exception) {  
     NSArray *arr = [exception callStackSymbols];  
     NSString *reason = [exception reason];  
     NSString *name = [exception name];
     WTInit(name,@"UncaughtExceptionHandler");
     WTAdd(arr,@"callStackSymbols");
     WTAdd(reason,@"reason");
     WTSave;
     WTRelease;
     if(OriginalExceptionHandler!=NULL){
        OriginalExceptionHandler(exception);
     }

}  



extern BOOL getBoolFromPreferences(NSString *preferenceValue) {
    if(GlobalConfig==nil){
        GlobalConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath];
    }
    id value = [GlobalConfig objectForKey:preferenceValue];
    if (value == nil) {
        return NO; // default to YES
    }
    BOOL retVal=[value boolValue];
    [value release];
    return retVal;
}


NSString* RandomString(){
NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
NSMutableString *s = [NSMutableString stringWithCapacity:9];
for (NSUInteger i = 0; i < 9; i++) {
    u_int32_t r = arc4random() % [alphabet length];
    unichar c = [alphabet characterAtIndex:r];
    [s appendFormat:@"%C", c];
}
return s;
}
static void traceURISchemes() {
    NSArray *url_schemes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for (id schemeBundle in url_schemes) {
        NSString *name = [schemeBundle objectForKey:@"CFBundleURLName"];
        NSNumber *isPrivate = [schemeBundle objectForKey:@"CFBundleURLIsPrivate"];
        for (id scheme in [schemeBundle objectForKey:@"CFBundleURLSchemes"]) {
        CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CFBundleURLTypes" andMethod:@"CFBundleURLSchemes"];
        [tracer addArgFromPlistObject:name withKey:@"CFBundleURLName"];
        [tracer addArgFromPlistObject:isPrivate withKey:@"CFBundleURLIsPrivate"];
        [tracer addArgFromPlistObject:scheme withKey:@"CFBundleURLScheme"];
        [traceStorage saveTracedCall:tracer];
        [tracer release];
        }
    }
}
static void runSanityFix(){
    if(getBoolFromPreferences(@"Reveal")&&getBoolFromPreferences(@"Reveal2")){
        [GlobalConfig setObject:[NSNumber numberWithBool:NO] forKey:@"Reveal"];
        [GlobalConfig writeToFile:preferenceFilePath atomically:YES];
        NSLog(@"Turn on both Reveal and Reveal2 with results in an instant crash. Disabled Reveal");
    }
}
%ctor {
    //Stop Reveal
#ifndef NonJailbroken   

dlopen("/usr/lib/libsubstrate.dylib",RTLD_NOW|RTLD_GLOBAL);
#endif
     [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStop" object:nil];
    // Only hook Apps the user has selected in WTFJH's settings panel
    NSString *appId = [[NSBundle mainBundle] bundleIdentifier];
    if (appId == nil) {
        appId = [[NSProcessInfo processInfo] processName];//A Fix By https://github.com/radj 
        NSLog(@"WTFJH - Process has no bundle ID, use process name instead: %@", appId);
    }
    
    // Load WTFJH preferences
    id shouldHook = [[[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath] objectForKey:appId];
    if ( (shouldHook == nil) || (! [shouldHook boolValue]) ) {
        NSLog(@"WTFJH - Profiling disabled for %@", appId);
        return;
    }
    //Don't run sanity check for unselected apps
    runSanityFix();

    NSLog(@"WTFJH - Profiling enabled for %@", appId);
    if (getBoolFromPreferences(@"URLSchemesHooks")) {
            traceURISchemes();
     }
    if (getBoolFromPreferences(@"RedirectLogging")) {
            BOOL status=RedirectLog();
            if(status==NO){
                NSLog(@"Redirect Failed");
            }
     }


    BOOL shouldLog = getBoolFromPreferences(@"LogToTheConsole");
    [[SQLiteStorage sharedManager] initWithDefaultDBFilePathAndLogToConsole: shouldLog];
    if(getBoolFromPreferences(@"RegisterCustomExceptionHandler")){
        NSLog(@"Registering UncaughtExceptionHandler");
        OriginalExceptionHandler=NSGetUncaughtExceptionHandler();
        NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    }

    if (traceStorage != nil) {


        NSLog(@"WTFJH - Enabling Hooks");
        extern void GlobalInit();
        GlobalInit();
    }
    else {
        NSLog(@"WTFJH - DB Initialization error; disabling hooks.");
        return ;
    }

}





%dtor{
    //This provided by Modern Theos. Theos-Legacy support has been discarded by WTFJH.
    [[SQLiteStorage sharedManager] dealloc];


}











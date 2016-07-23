#import "./Hooks/SharedDefine.pch" 
#include <unistd.h>
#include <stdio.h>

static BOOL RedirectLog(){
    NSString* fileName=[NSString stringWithFormat:@"%@/%@-%@.txt",NSHomeDirectory(),[NSDate date],[[NSProcessInfo processInfo] processName]];
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
extern BOOL getBoolFromPreferences(NSString *preferenceValue) {
    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath];
    id value = [preferences objectForKey:preferenceValue];
    if (value == nil) {
        return NO; // default to YES
    }
    [preferences release];
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

%ctor {
    //Stop Reveal
#ifndef NonJailbroken   

dlopen("/usr/lib/libsubstrate.dylib",RTLD_NOW|RTLD_GLOBAL);
#endif
     [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStop" object:nil];


    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

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
        [pool drain];
	    return;
    }
    if (getBoolFromPreferences(@"URLSchemesHooks")) {
            traceURISchemes();
     }
    if (getBoolFromPreferences(@"RedirectLogging")) {
            BOOL status=RedirectLog();
            if(status==NO){
                NSLog(@"Redirect Failed");
            }
     }
	// Initialize DB storage
    NSLog(@"WTFJH - Profiling enabled for %@", appId);
    BOOL shouldLog = getBoolFromPreferences(@"LogToTheConsole");
    [[SQLiteStorage sharedManager] initWithDefaultDBFilePathAndLogToConsole: shouldLog];
	if (traceStorage != nil) {
        NSLog(@"WTFJH - Enabling Hooks");
        extern void GlobalInit();
        GlobalInit();
	}
	else {
		NSLog(@"WTFJH - DB Initialization error; disabling hooks.");
	}

    [pool drain];
}
#import "CallStackInspector.h"
static BOOL MehPref(NSString *preferenceValue) {
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
@implementation CallStackInspector

+ (BOOL) wasCalledByAppAtIndex:(NSUInteger)index {
    if(MehPref(@"Verbose")==YES){
        return YES;
    }


    NSString *appProcessName = [[[NSProcessInfo processInfo] processName] autorelease];
    NSArray *callStack = [[NSThread callStackSymbols] autorelease];
    // Not ideal: Check if the app's process name is close enough in the call stack
    if ([[callStack objectAtIndex:index] containsString:appProcessName]) {
        return YES;
    }
    return NO;
}

+ (BOOL) wasDirectlyCalledByApp {
    if(MehPref(@"Verbose")==YES){
        return YES;
    }

	return [self wasCalledByAppAtIndex:3];
}

+ (BOOL) wasDirectlyCalledByFunctionWithName:(NSString*)name {
    if(MehPref(@"Verbose")==YES){
        return YES;
    }

    NSArray *callStack = [[NSThread callStackSymbols] autorelease];
    NSString* callerName = [[callStack objectAtIndex:2] autorelease];
    if ([callerName containsString:name]) {

        return YES;
    } else {

        return NO;
    }
}

@end

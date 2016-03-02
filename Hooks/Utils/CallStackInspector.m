#import "CallStackInspector.h"
@implementation CallStackInspector

+ (BOOL) wasCalledByAppAtIndex:(NSUInteger)index {
    NSString *appProcessName = [[[NSProcessInfo processInfo] processName] autorelease];
    NSArray *callStack = [[NSThread callStackSymbols] autorelease];
    // Not ideal: Check if the app's process name is close enough in the call stack
    if ([[callStack objectAtIndex:index] containsString:appProcessName]) {
        return YES;
    }
    return NO;
}

+ (BOOL) wasDirectlyCalledByApp {
	return [self wasCalledByAppAtIndex:3];
}

+ (BOOL) wasDirectlyCalledByFunctionWithName:(NSString*)name {
    NSArray *callStack = [[NSThread callStackSymbols] autorelease];
    NSString* callerName = [[callStack objectAtIndex:2] autorelease];
    if ([callerName containsString:name]) {

        return YES;
    } else {

        return NO;
    }
}

@end

#import "CallStackInspector.h"
@implementation CallStackInspector

+ (BOOL) wasCalledByAppAtIndex:(NSUInteger)index {
    NSString *appProcessName = [[[NSProcessInfo processInfo] processName] autorelease];
    NSArray *callStack = [[NSThread callStackSymbols] autorelease];
    // Not ideal: Check if the app's process name is close enough in the call stack
    NSRange callerAtIndex = [[callStack objectAtIndex:index] rangeOfString: appProcessName];
    if (callerAtIndex.location == NSNotFound) {
        return NO;
    }
    return YES;
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

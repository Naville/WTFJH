#import "CallStackInspector.h"


@implementation CallStackInspector



+ (BOOL) wasCalledByAppAtIndex:(NSUInteger)index {
    //NSLog(@"%@",[NSThread callStackSymbols]);
    NSString *appProcessName = [[NSProcessInfo processInfo] processName];
    NSArray *callStack = [NSThread callStackSymbols];

    // Not ideal: Check if the app's process name is close enough in the call stack
    NSRange callerAtIndex = [[callStack objectAtIndex:index] rangeOfString: appProcessName];
   
    if (callerAtIndex.location == NSNotFound) {
        return false;
    }
    return true;
}

+ (BOOL) wasDirectlyCalledByApp {
	return [self wasCalledByAppAtIndex:3];
}
+ (BOOL) wasDirectlyCalledByFunctionWithName:(NSString*)name {
    NSArray *callStack = [NSThread callStackSymbols];
    NSString* callerName=[callStack objectAtIndex:2];/*0:Current Method 
                                                        1:Method Calling Current Method
                                                        2:Method Calling 1
                                        
                                                        */
    if([callerName containsString:name]){
        return YES;
    }
    else{
        return NO;
    }
}


@end

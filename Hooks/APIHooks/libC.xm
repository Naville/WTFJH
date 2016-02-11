
#include <substrate.h>
#import "../Utils/SQLiteStorage.h"
#import "../Utils/PlistObjectConverter.h"
#import "../Utils/CallStackInspector.h"
#import "../SharedDefine.pch"


// Hook rand()
static int (*original_rand)();

static int replaced_rand() {

    int origResult = original_rand();

    // Only log what the application directly calls. For example we don't want to log internal SSL crypto calls
    if ([CallStackInspector wasDirectlyCalledByApp]) {

        CallTracer *tracer = [[CallTracer alloc] initWithClass:@"C" andMethod:@"rand"];
        [tracer addReturnValueFromPlistObject: [NSNumber numberWithUnsignedInt:origResult]];
        [traceStorage saveTracedCall: tracer];
        [tracer release];
    }
    return origResult;
}


// Hook random()
static long (*original_random)();

static long replaced_random() {

    long origResult = original_random();

    // Only log what the application directly calls. For example we don't want to log internal SSL crypto calls
    if ([CallStackInspector wasDirectlyCalledByApp]) {

        CallTracer *tracer = [[CallTracer alloc] initWithClass:@"C" andMethod:@"random"];
        [tracer addReturnValueFromPlistObject: [NSNumber numberWithUnsignedLong:origResult]];
        [traceStorage saveTracedCall: tracer];
        [tracer release];
    }
    return origResult;
}




extern void init_libC_hook(){
    MSHookFunction((void *)random, (void *)replaced_random, (void **) &original_random);
    MSHookFunction((void *)rand, (void *)replaced_rand, (void **) &original_rand);
}


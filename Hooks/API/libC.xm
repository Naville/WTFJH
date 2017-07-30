
#include <substrate.h>
#import "../Utils/SQLiteStorage.h"
#import "../Utils/PlistObjectConverter.h"
#import "../Utils/CallStackInspector.h"
#import "../Global.h"

extern BOOL getBoolFromPreferences(NSString *preferenceValue);
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


static int (*original_system)(char* command);
int replaced_system(char *command){
        if (WTShouldLog) {
                NSString* cmd=[NSString stringWithUTF8String:command];
                int ret=-1;
                WTInit(@"C",@"system");
                WTAdd(cmd,@"Command");
                if(getBoolFromPreferences(@"AntiAntiDebugging")==YES && [cmd.uppercaseString containsString:@"KILL"] && [cmd.uppercaseString containsString:@"DEBUGSERVER"]) {
                        WTAdd(@"Possible Anti-Debugging Attempt.Hjacked",@"AntiAntiDebugging");
                }
                else{
                        ret=original_system(command);
                }
                WTReturn([NSNumber numberWithInt:ret]);
                WTSave;
                WTRelease;
                return ret;
        }
        return original_system(command);


}
static char* (*original_getenv)(char* name);
char* replaced_getenv(char *command){
  char* ret=original_getenv(command);
  if (WTShouldLog) {
          WTInit(@"C",@"getenv");
          WTAdd([NSString stringWithUTF8String:command],@"name");
          WTReturn([NSString stringWithUTF8String:ret]);
          WTSave;
          WTRelease;
          return ret;
  }
  return ret;
}


extern void init_libC_hook(){
        WTHookFunction((void *)random, (void *)replaced_random, (void **) &original_random);
        WTHookFunction((void *)rand, (void *)replaced_rand, (void **) &original_rand);
        WTHookFunction((void *)system, (void *)replaced_system, (void **) &original_system);
        WTHookFunction((void *)system, (void *)replaced_getenv, (void **) &original_getenv);
}

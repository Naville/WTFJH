#import "CallTracer.h"
#import <Global.h>
#if 0
#define NSLog WTFJHLog
#endif
extern void WTFJHLog(id Obj1, ... );
@interface SQLiteStorage : NSObject {

}
+(SQLiteStorage *)sharedManager;
- (SQLiteStorage *)initWithDefaultDBFilePathAndLogToConsole: (BOOL) shouldLog;
- (SQLiteStorage *)initWithDBFilePath:(NSString *) DBFilePath andLogToConsole: (BOOL) shouldLog;
- (BOOL)saveTracedCall: (CallTracer*) tracedCall;
- (void)dealloc;
@end


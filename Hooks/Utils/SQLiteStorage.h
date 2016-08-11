#import "CallTracer.h"
#import <SharedDefine.pch>
#if 0
#define NSLog WTFJHLog
#endif
extern void WTFJHLog(id Obj1, ... );
@interface SQLiteStorage : NSObject {

}
+(id)sharedManager;
- (SQLiteStorage *)initWithDefaultDBFilePathAndLogToConsole: (BOOL) shouldLog;
- (SQLiteStorage *)initWithDBFilePath:(NSString *) DBFilePath andLogToConsole: (BOOL) shouldLog;
- (BOOL)saveTracedCall: (CallTracer*) tracedCall;


@end


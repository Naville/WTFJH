#import "RuntimeUtils.h"
#import "../SharedDefine.pch"
@interface Utils : NSObject {
}
+(id)sharedManager;
+(NSMutableArray*)classListForSelector:(SEL)Selector;
#ifdef PROTOTYPE
-(NSArray*)possibleClassNameFromSignature:(NSString*)className;
#endif
@property(nonatomic,strong) NSDictionary *signatureDatabase;
@property(nonatomic,strong) NSNumber* MinimumMatchConfidence;
@end
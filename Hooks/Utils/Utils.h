@interface Utils : NSObject {

}
+(id)sharedManager;
+(NSMutableArray*)classListForSelector:(SEL)Selector;

@end
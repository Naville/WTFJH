@interface Utils : NSObject {

}
@property (atomic, copy) NSArray *filterList;
+(id)sharedManager;
+(NSMutableArray*)classListForSelector:(SEL)Selector;

@end
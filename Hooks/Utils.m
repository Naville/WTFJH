#import "./Utils.h"
#import "./SharedDefine.pch"
@implementation Utils : NSObject
+(id)sharedManager{
 	static Utils *sharedUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtils = [[self alloc] init];
    });
    return sharedUtils;


}
+(NSMutableArray*)classListForSelector:(SEL)Selector{
int numClasses;
NSMutableArray* returnArray=[NSMutableArray array];
Class *classes = NULL;

classes = NULL;
numClasses = objc_getClassList(NULL, 0);
NSLog(@"Number of classes: %d", numClasses);

if (numClasses > 0 )
{
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    for (int i = 0; i < numClasses; i++) {
        id obj=[[classes[i] alloc] init];
        if([obj respondsToSelector:Selector]){

        [returnArray addObject:NSStringFromClass([obj class])];
        }
    }
    free(classes);
}

return returnArray;
}
@end
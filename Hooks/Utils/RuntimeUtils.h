#import "../Global.h"
#import <objc/runtime.h>
@interface RuntimeUtils : NSObject {

}
+(NSMutableDictionary*)propertyListForObject:(id)Object;
+(NSMutableDictionary*)propertyListForClass:(NSString*)className;
+(NSMutableDictionary*)methodsForClass:(NSString*)className;
+(NSMutableDictionary*)protocalForClass:(NSString*)className;
+(NSMutableDictionary*)ivarForClass:(NSString*)className;
@end

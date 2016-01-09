#import "RuntimeUtils.h"
@implementation RuntimeUtils : NSObject
+(NSDictionary*)propertyListForObject:(id)Object{
	unsigned pcount;
    objc_property_t *props = class_copyPropertyList([Object class], &pcount);
 	NSMutableDictionary *PropList = [NSMutableDictionary dictionary];

    unsigned i;
    for (i = 0; i < pcount; i++)
    {
        objc_property_t property = props[i];
        NSString *PropName = [NSString stringWithUTF8String:property_getName(property)];
        [PropList setObject:[Object valueForKey:PropName] forKey:PropName];
    }

    free(props);

    return PropList;

}
@end
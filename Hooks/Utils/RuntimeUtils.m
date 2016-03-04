#import "RuntimeUtils.h"
@implementation RuntimeUtils : NSObject
+(NSMutableDictionary*)propertyListForObject:(id)Object{
	unsigned pcount;
    objc_property_t *props = class_copyPropertyList([Object class], &pcount);
 	NSMutableDictionary *PropList = [NSMutableDictionary dictionary];

    unsigned i;
    for (i = 0; i < pcount; i++)
    {
        objc_property_t property = props[i];
        NSString *PropName = [NSString stringWithUTF8String:property_getName(property)];
        id propObject=[Object valueForKey:PropName];
        if(propObject!=nil){
            [PropList setObject:propObject forKey:PropName];
                            }
        [propObject release];
        [PropName release];
    }

    free(props);

    return PropList;

}
+(NSMutableDictionary*)propertyListForClass:(NSString*)className{
    NSMutableDictionary* returnDictionary=[NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(objc_getClass(className.UTF8String), &count);
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        unsigned int attributecount;
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        objc_property_attribute_t *attributes=property_copyAttributeList(property,&attributecount);
        NSMutableString* attriCombinedString=[NSMutableString string];
        for(int j=0;j<attributecount;j++){
            objc_property_attribute_t attr=attributes[j];
            NSString* attriString=[NSString stringWithUTF8String:attr.name];
            [attriCombinedString appendString:attriString];
            
            
        }
        free(attributes);
        [returnDictionary setObject:attriCombinedString forKey:name];
    }
    
    free(properties);
    //NSLog(@"Properties %@",returnDictionary);
    return returnDictionary;
}
+(NSMutableDictionary*)ivarForClass:(NSString*)className{
    NSMutableDictionary* returnDict=[NSMutableDictionary dictionary];
    unsigned int count;
    Ivar * IvarList=class_copyIvarList(objc_getClass(className.UTF8String), &count);
    for(int i=0;i<count;i++){
        Ivar currentIvar=IvarList[i];
        NSString* IvarName=[NSString stringWithFormat:@"%s",ivar_getName(currentIvar)];
        NSString* IvarOffset=[NSString stringWithFormat:@"%lu",(unsigned long)ivar_getOffset(currentIvar)];
        //NSLog(@"Offset:%@",IvarOffset);
        NSDictionary* ivarInfoDict=[NSDictionary dictionaryWithObjectsAndKeys:IvarName,@"Name", IvarOffset,@"Offset",[NSString stringWithUTF8String:ivar_getTypeEncoding(currentIvar)],@"TypeEncoding",nil];
        //NSLog(@"iVARinfo:%@",ivarInfoDict);
        [returnDict setObject:ivarInfoDict forKey:[NSString stringWithUTF8String:ivar_getName(currentIvar)]];
        
        
        
    }
    free(IvarList);
    
    return returnDict;
}
+(NSMutableDictionary*)protocalForClass:(NSString*)className{
    NSMutableDictionary* ReturnDict=[NSMutableDictionary dictionary];
    NSMutableArray* protoList=[NSMutableArray array];
    unsigned int count;
    Protocol **protocalList=class_copyProtocolList(objc_getClass(className.UTF8String), &count);
    for(int i=0;i<count;i++){
        NSString* protoName=[NSString stringWithUTF8String:protocol_getName(protocalList[i])];
        [protoList addObject:protoName];
        
    }
    
    [ReturnDict setObject:protoList forKey:@"Protocal"];
    return ReturnDict;
}
+(NSMutableDictionary*)methodsForClass:(NSString*)className{
    NSMutableDictionary* returnDictionary=[NSMutableDictionary dictionary];
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(objc_getClass(className.UTF8String), &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        NSString* methodName=[NSString stringWithFormat:@"%s",sel_getName(method_getName(method))];
        NSString* TypeEncoding=[NSString stringWithFormat:@"%s",method_getTypeEncoding(method)];
        NSString* ReturnType=[NSString  stringWithFormat:@"%s",method_copyReturnType(method)];
        NSMutableArray* ArgumentTypeArray=[NSMutableArray array];
        int argumentNum=method_getNumberOfArguments(method);
        for(int Q=0;Q<argumentNum;Q++){
            NSString* ArgType=[NSString stringWithFormat:@"%s",method_copyArgumentType(method,Q)];
            [ArgumentTypeArray addObject:ArgType];
            
        }
        NSDictionary* methodDict=[NSDictionary dictionaryWithObjectsAndKeys:TypeEncoding,@"TypeEncoding" ,ReturnType,@"ReturnType",ArgumentTypeArray,@"ArgumentType",nil];
        [returnDictionary setObject:methodDict forKey:methodName];
    }
    free(methods);
    Method *methods2 = class_copyMethodList(objc_getMetaClass(className.UTF8String), &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods2[i];
        NSString* methodName=[NSString stringWithFormat:@"%s",sel_getName(method_getName(method))];
        NSString* TypeEncoding=[NSString stringWithFormat:@"%s",method_getTypeEncoding(method)];
        NSString* ReturnType=[NSString  stringWithFormat:@"%s",method_copyReturnType(method)];
        NSMutableArray* ArgumentTypeArray=[NSMutableArray array];
        int argumentNum=method_getNumberOfArguments(method);
        for(int Q=0;Q<argumentNum;Q++){
             NSString* ArgType=[NSString stringWithFormat:@"%s",method_copyArgumentType(method,Q)];
            [ArgumentTypeArray addObject:ArgType];
            
        }
        
        
        
        NSDictionary* methodDict=[NSDictionary dictionaryWithObjectsAndKeys:TypeEncoding,@"TypeEncoding" ,ReturnType,@"ReturnType",ArgumentTypeArray,@"ArgumentType",nil];
        [returnDictionary setObject:methodDict forKey:methodName];

    }
    free(methods2);
    
    return returnDictionary;
    
}
@end
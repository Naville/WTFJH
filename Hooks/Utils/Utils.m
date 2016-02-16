#import "Utils.h"
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
#ifdef PROTOTYPE
-(NSArray*)possibleClassNameFromSignature:(NSString*)className{
    NSMutableDictionary* propDict=[RuntimeUtils propertyListForClass:className];
    NSMutableDictionary* methodDict=[RuntimeUtils methodsForClass:className];
    NSMutableDictionary* ivarDict=[RuntimeUtils ivarForClass:className];
    NSMutableDictionary* protoDict=[RuntimeUtils protocalForClass:className];
    for(id key in self.signatureDatabase){
    NSDictionary* currentSig=[self.signatureDatabase objectForKey:key];
    //double Confidence=0.00;
    /*
    We Use A Mark Based Algorithm To Measure Confidence 
    Super Class:10%
    Protocals:15%
    Methods,Properties,IVARS:25% EACH
    */

    [currentSig release];
    }
    [propDict release];
    [methodDict release];
    [ivarDict release];
    [protoDict release];
    return nil;
}
-(void)setupSignatureDatabase{
#ifdef WTFJHTWEAKNAME
#pragma message "Don't Change This Filename Or Setup Will Crash:" Meh(WTFJHTWEAKNAME)
    for(int i=0;i<_dyld_image_count();i++){
        const char * Nam=_dyld_get_image_name(i);
        NSString* curName=[NSString stringWithUTF8String:Nam];
        if([curName containsString:WTFJHTWEAKNAME]){
            //We Found Ourself
#ifndef _____LP64_____
            uint32_t size=0;
            const struct mach_header*   selfHeader=(const struct mach_header*)_dyld_get_image_header(i);
            char * data=getsectdatafromheader(selfHeader,"WTFJH","SIGDB",&size);

#elif 
            uint64_t size=0;
            const struct mach_header_64*   selfHeader=(const struct mach_header_64*)_dyld_get_image_header(i);
            char * data=getsectdatafromheader_64(selfHeader,"WTFJH","SIGDB",&size);
#endif
            NSData* SDData=[NSData dataWithBytes:data length:size];
            self.signatureDatabase = [NSJSONSerialization JSONObjectWithData:SDData
                                                             options:NSJSONReadingAllowFragments
                                                              error:nil]; 



            [SDData release];
            free(data);

        break;
        }
        [curName release];


    }
#elif
#error "WTFJHTWEAKNAME NOT DEFINED"

#endif

}
#endif
@end
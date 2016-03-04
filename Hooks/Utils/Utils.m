#import "Utils.h"
#define TotalIvarScore 0.2
#define SuperClassNameMatch 0.2
#define IvarOffsetMatch 0.2
#define IvarTypeEncodingMatch 0.4
#define IvarNameMatch 0.6
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
    NSMutableDictionary* MatchedIvarDatabase=[NSMutableDictionary dictionary];

    NSMutableDictionary* propDict=[RuntimeUtils propertyListForClass:className];
    NSMutableDictionary* methodDict=[RuntimeUtils methodsForClass:className];
    NSMutableDictionary* ivarDict=[RuntimeUtils ivarForClass:className];
    NSMutableDictionary* protoDict=[RuntimeUtils protocalForClass:className];
    NSString* SuperClass=[NSString stringWithFormat:@"%s",class_getName(class_getSuperclass(objc_getClass(className.UTF8String)))];
    for(id key in self.signatureDatabase.allKeys){
    NSDictionary* currentSig=[self.signatureDatabase objectForKey:key];
    double Confidence=0.00;
    if [[currentSig objectForKey:@"SuperClass"] isEqualToString:SuperClass]{//Superclass Compare
        Confidence=Confidence+0.1;
    }
    double FullMatchScoreForIvar=TotalIvarScore/ivarDict.allKeys.count;
    for(id IvarKey in ivarDict.allKeys){//IVAR Names. a.k.a. Keys
        NSDictionary* RecordInDB=[[currentSig objectForKey:@"Ivar"] objectForKey:IvarKey];
        if (RecordInDB!=nil){//Name Match. Matching Signatures
            if([[RecordInDB objectForKey:@"Offset"] isEqualToString:[[ivarDict objectForKey:IvarKey] objectForKey:@"Offset"]){
                Confidence=Confidence+FullMatchScoreForIvar*IvarOffsetMatch;
            }
            if([[RecordInDB objectForKey:@"TypeEncoding"] isEqualToString:[[ivarDict objectForKey:IvarKey] objectForKey:@"TypeEncoding"]){
                Confidence=Confidence+FullMatchScoreForIvar*IvarTypeEncodingMatch;
            }
            if([[RecordInDB objectForKey:@"Name"] isEqualToString:[[ivarDict objectForKey:IvarKey] objectForKey:@"Name"]){
                Confidence=Confidence+FullMatchScoreForIvar*IvarNameMatch;
            }

        }
       else{
        //Name Didn't Match. Iterate All Records
            for (NSString* SigName in [[currentSig objectForKey:@"Ivar"] allKeys]){
                NSDictionary* RecordInDB=[[currentSig objectForKey:@"Ivar"] objectForKey:SigName];//One Record in DB
                if([[RecordInDB objectForKey:@"Offset"] isEqualToString:[[ivarDict objectForKey:IvarKey] objectForKey:@"Offset"]){
                Confidence=Confidence+FullMatchScoreForIvar*IvarOffsetMatch;
                    }
                if([[RecordInDB objectForKey:@"TypeEncoding"] isEqualToString:[[ivarDict objectForKey:IvarKey] objectForKey:@"TypeEncoding"]){
                Confidence=Confidence+FullMatchScoreForIvar*IvarTypeEncodingMatch;
                    }
                if([[RecordInDB objectForKey:@"Name"] isEqualToString:[[ivarDict objectForKey:IvarKey] objectForKey:@"Name"]){
                Confidence=Confidence+FullMatchScoreForIvar*IvarNameMatch;
                    }                
                if(Confidence>self.MinimumMatchConfidence.intValue){
                    NSArray* oldArray=[MatchedIvarDatabase objectForKey:[ivarDict objectForKey:IvarKey]];//Key is IVAR Name in Binary
                    [oldArray addObject:[RecordInDB objectForKey:@"Name"]];//Add current Match
                    [MatchedDatabase setObject:oldArray forKey:[ivarDict objectForKey:IvarKey]];
                    //Add This To MatchedDatabase

                }

            }
        

        }
    //Insert Other matches Here
    
    }


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
    NSDictionary* prefs=[[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath];
    self.MinimumMatchConfidence=[prefs objectForKey:@"MinimumMatchConfidence"];
    [prefs release];
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
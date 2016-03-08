#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>
#import <mach-o/dyld.h>
#import "Dumper.h"
static void LoadDumper(){
    //Protocol **objc_copyProtocolList(unsigned int *outCount)
    NSMutableArray* classList=[NSMutableArray array];
    NSMutableArray* protocalList=[NSMutableArray array];
    NSLog(@"classRTDump Loaded");
    unsigned int count;
    const char **classes;
    classes = objc_copyClassNamesForImage([[[NSBundle mainBundle] executablePath] UTF8String], &count);
    
    for (int i = 0; i < count; i++) {
        NSString* className=[NSString stringWithFormat:@"%s",classes[i]];
        //NSLog(@"Class name: %@",className);
        [classList addObject:className];

        
    }
    free(classes);
    unsigned int protocolNumber;
    Protocol **Protocols=objc_copyProtocolList(&protocolNumber);
    for(int j=0;j<protocolNumber;j++){
        Protocol* currentProtocal=Protocols[j];
        NSString* protocalName=[NSString stringWithFormat:@"%s",protocol_getName(currentProtocal)];
       // NSLog(@"ProtocalName:%@",protocalName);
        [protocalList addObject:protocalName];
        
        
    }
    free(Protocols);
    
    
    Dumper* dumper=[Dumper dumper];
    //NSLog(@"ClassList:%@",classList);
    //NSLog(@"ProtocalList:%@",protocalList);
    [dumper setupWithClassList:classList protocalList:protocalList];
    [dumper startDump];
    [dumper OutPutToPath:[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()]];
    
}
void __attribute__((constructor)) InitclassRTDumper(){
        LoadDumper();
}


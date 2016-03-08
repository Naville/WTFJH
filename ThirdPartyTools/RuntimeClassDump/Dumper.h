//
//  Dumper.h
//  
//
//  Created by Zhang Naville on 23/12/2015.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>
#import <mach-o/dyld.h>

@interface Dumper : NSObject
+(id)dumper;
-(void)setupWithClassList:(NSArray*)classList protocalList:(NSArray*)protocalList;
-(void)startDump;
-(void)OutPutToPath:(NSString*)Path;
-(void)FixProtocalList;
@end

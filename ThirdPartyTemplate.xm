//Shall We Use Marcos instead of this shit?
#import "../SharedDefine.pch"
#import <mach-o/getsect.h>
#import <dlfcn.h>
static NSString* RandomString(){
NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
NSMutableString *s = [NSMutableString stringWithCapacity:9];
for (NSUInteger i = 0; i < 9; i++) {
    u_int32_t r = arc4random() % [alphabet length];
    unichar c = [alphabet characterAtIndex:r];
    [s appendFormat:@"%C", c];
}
return s;
}
extern void init_TEMPLATENAME_hook(){
	 for(int i=0;i<_dyld_image_count();i++){
        const char * Nam=_dyld_get_image_name(i);
        NSString* curName=[[NSString stringWithUTF8String:Nam] autorelease];
        if([curName containsString:WTFJHTWEAKNAME]){
            //We Found Ourself
#ifndef _____LP64_____
            uint32_t size=0;
            const struct mach_header*   selfHeader=(const struct mach_header*)_dyld_get_image_header(i);
            char * data=getsectdatafromheader(selfHeader,"WTFJH","TEMPLATENAME",&size);

#elif 
            uint64_t size=0;
            const struct mach_header_64*   selfHeader=(const struct mach_header_64*)_dyld_get_image_header(i);
            char * data=getsectdatafromheader_64(selfHeader,"WTFJH","TEMPLATENAME",&size);
#endif
            NSData* SDData=[NSData dataWithBytes:data length:size];
            NSString* randomPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),RandomString()];
            [SDData writeToFile:randomPath atomically:YES];
            dlopen(randomPath.UTF8String,RTLD_NOW);
            //Inform Our Logger
            CallTracer *tracer = [[CallTracer alloc] initWithClass:@"WTFJH" andMethod:@"LoadThirdPartyTools"];
        	[tracer addArgFromPlistObject:@"dlopen" withKey:@"Type"];
        	[tracer addArgFromPlistObject:randomPath withKey:@"Path"];
            [tracer addArgFromPlistObject:@"TEMPLATENAME" withKey:@"ModuleName"];
        	[traceStorage saveTracedCall: tracer];
        	[tracer release];
        	//End

            [SDData release];
              break;
        }



    }
}

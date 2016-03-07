#import "../SharedDefine.pch"
#import <CoreFoundation/CoreFoundation.h>
 CFTypeRef (*old_MGCopyAnswer)(CFStringRef property);
 CFTypeRef (*old_MGCopyMultipleAnswers)(CFArrayRef questions, int __unknown0);
 int (*old_MGSetAnswer)(CFStringRef question, CFTypeRef answer);


 CFTypeRef MGCopyAnswer(CFStringRef property){
	CFTypeRef ReturnVal=old_MGCopyAnswer(property);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"libMobileGestalt" andMethod:@"MGCopyAnswer"];
	[tracer addArgFromPlistObject:(__bridge NSString*)property withKey:@"QueryPropertyName"];
	[tracer addReturnValueFromPlistObject:(__bridge NSArray*)ReturnVal];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	 return ReturnVal;
 }
CFTypeRef MGCopyMultipleAnswers(CFArrayRef questions, int __unknown0){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"libMobileGestalt" andMethod:@"MGCopyMultipleAnswers"];
	[tracer addArgFromPlistObject:(__bridge NSArray*)questions withKey:@"QueryPropertyNames"];
	[tracer addArgFromPlistObject:[NSNumber numberWithInt:__unknown0] withKey:@"UsageUnknown"];
	CFTypeRef ReturnVal=old_MGCopyMultipleAnswers(questions,__unknown0);
	[tracer addReturnValueFromPlistObject:(__bridge NSArray*)ReturnVal];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	 return ReturnVal;


}
int MGSetAnswer(CFStringRef question, CFTypeRef answer){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"libMobileGestalt" andMethod:@"MGSetAnswer"];
	[tracer addArgFromPlistObject:(__bridge NSString*)question withKey:@"Question"];
	[tracer addArgFromPlistObject:(__bridge NSObject*)answer withKey:@"Answer"];
	int ReturnVal=old_MGSetAnswer(question,answer);
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt:ReturnVal]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	 return ReturnVal;


}
static void MobileGestaltdyldCallBack(const struct mach_header* mh, intptr_t vmaddr_slide){
	Dl_info image_info;
	dladdr(mh, &image_info);//Will This Trigger Our Hook in DLFCN?
	const char *image_name = image_info.dli_fname;
	NSString* name=[NSString stringWithUTF8String:image_name];
	if([name containsString:@"MobileGestalt"]){
		MSHookFunction(((void*)MSFindSymbol(NULL, "_MGCopyAnswer")),(void*)MGCopyAnswer, (void**)&old_MGCopyAnswer);
		MSHookFunction(((void*)MSFindSymbol(NULL, "_MGCopyMultipleAnswers")),(void*)MGCopyMultipleAnswers, (void**)&old_MGCopyMultipleAnswers);
		MSHookFunction(((void*)MSFindSymbol(NULL, "_MGSetAnswer")),(void*)MGSetAnswer, (void**)&old_MGSetAnswer);
	
	}
	[name release];
}


extern void init_libMobileGestalt_hook(){
_dyld_register_func_for_add_image(&MobileGestaltdyldCallBack);
}

//Shall We Check Entitlement com.apple.private.MobileGestalt.AllowedProtectedKeys ,which is needed for certain keys?

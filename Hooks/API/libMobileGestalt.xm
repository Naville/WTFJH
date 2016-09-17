#import "../Global.h"
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
static void Loader(){
	WTHookFunction(((void*)MSFindSymbol(NULL, "_MGCopyAnswer")),(void*)MGCopyAnswer, (void**)&old_MGCopyAnswer);
	WTHookFunction(((void*)MSFindSymbol(NULL, "_MGCopyMultipleAnswers")),(void*)MGCopyMultipleAnswers, (void**)&old_MGCopyMultipleAnswers);
	WTHookFunction(((void*)MSFindSymbol(NULL, "_MGSetAnswer")),(void*)MGSetAnswer, (void**)&old_MGSetAnswer);
}


WTCallBack(@"Gestalt",Loader)
extern void init_libMobileGestalt_hook(){
WTAddCallBack(Loader);
}

//Shall We Check Entitlement com.apple.private.MobileGestalt.AllowedProtectedKeys ,which is needed for certain keys?

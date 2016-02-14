#import "../SharedDefine.pch"
#import <CoreFoundation/CoreFoundation.h>
 CFPropertyListRef (*old_MGCopyAnswer)(CFStringRef property);
 CFPropertyListRef (*old_MGCopyMultipleAnswers)(CFArrayRef questions, int __unknown0);
 int (*old_MGSetAnswer)(CFStringRef question, CFTypeRef answer);


 CFPropertyListRef MGCopyAnswer(CFStringRef property){
	CFPropertyListRef ReturnVal=old_MGCopyAnswer(property);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"libMobileGestalt" andMethod:@"MGCopyAnswer"];
	[tracer addArgFromPlistObject:(__bridge NSString*)property withKey:@"QueryPropertyName"];
	[tracer addReturnValueFromPlistObject:(__bridge NSArray*)ReturnVal];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	 return ReturnVal;
 }
CFPropertyListRef MGCopyMultipleAnswers(CFArrayRef questions, int __unknown0){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"libMobileGestalt" andMethod:@"MGCopyMultipleAnswers"];
	[tracer addArgFromPlistObject:(__bridge NSArray*)questions withKey:@"QueryPropertyNames"];
	[tracer addArgFromPlistObject:[NSNumber numberWithInt:__unknown0] withKey:@"UsageUnknown"];
	CFPropertyListRef ReturnVal=old_MGCopyMultipleAnswers(questions,__unknown0);
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

extern void init_libMobileGestalt_hook(){
MSHookFunction(((void*)MSFindSymbol(NULL, "_MGCopyAnswer")),(void*)MGCopyAnswer, (void**)&old_MGCopyAnswer);
MSHookFunction(((void*)MSFindSymbol(NULL, "_MGCopyMultipleAnswers")),(void*)MGCopyMultipleAnswers, (void**)&old_MGCopyMultipleAnswers);
MSHookFunction(((void*)MSFindSymbol(NULL, "_MGSetAnswer")),(void*)MGSetAnswer, (void**)&old_MGSetAnswer);
}

//Shall We Check Entitlement com.apple.private.MobileGestalt.AllowedProtectedKeys

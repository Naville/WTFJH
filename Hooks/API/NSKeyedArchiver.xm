#import "../SharedDefine.pch"
%group NSKeyedArchiver
%hook NSKeyedArchiver
+ (NSData *)archivedDataWithRootObject:(id)rootObject{
	NSData* origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSKeyedArchiver" andMethod:@"archivedDataWithRootObject:"];
	[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"RootObject"];
	[tracer addReturnValueFromPlistObject:origResult];
	[traceStorage saveTracedCall:tracer];
	[tracer release];
	return origResult;
}
%end // End-Hook NSKeyedArchiver
%end // End-Group NSKeyedArchiver
extern void init_NSKeyedArchiver_hook() {
	%init(NSKeyedArchiver);
}

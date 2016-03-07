#import "../SharedDefine.pch"
%group NSProcessInfo
%hook NSProcessInfo
+ (id)processInfo{
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"processInfo"];
		[tracer addReturnValueFromPlistObject:objectTypeNotSupported];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		return %orig;
}

-(NSDictionary*)environment{
	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"environment"];
	[tracer addReturnValueFromPlistObject:ret];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;


}
-(NSArray*)arguments{
	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"arguments"];
	[tracer addReturnValueFromPlistObject:ret];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;

}
-(NSString *)hostName{

		id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"hostName"];
	[tracer addReturnValueFromPlistObject:ret];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;
}
-(NSString *)processName{

	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"processName"];
	[tracer addReturnValueFromPlistObject:ret];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;	
}
-(int)processIdentifier{

	int ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"processIdentifier"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt:ret]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;	

}

-(NSString *)globallyUniqueString{
	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"globallyUniqueString"];
	[tracer addReturnValueFromPlistObject:ret];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;	


}
-(NSUInteger)processorCount{
	NSUInteger ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"processorCount"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithUnsignedInt:ret]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;	
}
-(NSUInteger)activeProcessorCount{
	NSUInteger ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"activeProcessorCount"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithUnsignedInt:ret]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;	
}
-(unsigned long long)physicalMemory{
	unsigned long long ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"physicalMemory"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithUnsignedLongLong:ret]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;	

}
-(NSTimeInterval)systemUptime{
	NSTimeInterval ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSProcessInfo" andMethod:@"systemUptime"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithDouble:ret]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;	

}

%end
%end
extern void init_NSProcessInfo_hook() {
    %init(NSProcessInfo);
}

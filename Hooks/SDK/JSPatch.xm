#import "../SharedDefine.pch"
%group JSPatch
%hook JPEngine
+ (id)evaluateScript:(NSString *)script{
	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"JSPatch" andMethod:@"evaluateScript:"];
	[tracer addArgFromPlistObject:script withKey:@"script"];
	[traceStorage saveTracedCall: tracer];
	[tracer addReturnValueFromPlistObject:ret];
		 
	[tracer release];
	return ret;
}
+ (void)addExtensions:(NSArray *)extensions{
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"JSPatch" andMethod:@"addExtensions:"];
	[tracer addArgFromPlistObject:extensions withKey:@"extensions"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	%orig;
}
+ (void)defineStruct:(NSDictionary *)defineDict{

	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"JSPatch" andMethod:@"defineStruct:"];
	[tracer addArgFromPlistObject:defineDict withKey:@"defineDict"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	%orig;

}

+ (void)startEngine{
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"JSPatch" andMethod:@"startEngine"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	%orig;
}
%end



%end
extern void init_JSPatch_hook() {
    %init(JSPatch);
}

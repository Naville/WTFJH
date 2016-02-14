#import "../SharedDefine.pch"
%group NSKeyedUnarchiver
%hook NSKeyedUnarchiver
+ (id)unarchiveObjectWithData:(NSData *)data {
	id origResult = %orig(data);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSKeyedUnarchiver" andMethod:@"unarchiveObjectWithData:"];
	[tracer addArgFromPlistObject:data withKey:@"data"];
	[tracer addReturnValueFromPlistObject:objectTypeNotSupported];
	[traceStorage saveTracedCall:tracer];
	[tracer release];
	return origResult;
}
%end // End-Hook NSKeyedUnarchiver
%end // End-Group NSKeyedUnarchiver
extern void init_NSKeyedUnarchiver_hook() {
	%init(NSKeyedUnarchiver);
}

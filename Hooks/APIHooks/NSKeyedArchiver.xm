#import "../SharedDefine.pch"
%group NSKeyedArchiver
//Insert Your Hook Here
%hook NSKeyedArchiver
+ (BOOL)archiveRootObject:(id)rootObject toFile:(NSString *)path {
	BOOL origResult = %orig(rootObject, path);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSKeyedArchiver" andMethod:@"archiveRootObject:toFile:"];
	[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"rootObject"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall:tracer];
	[tracer release];
	return origResult;
}
%end // End-Hook NSKeyedArchiver
%end // End-Group NSKeyedArchiver
extern void init_NSKeyedArchiver_hook() {
	%init(NSKeyedArchiver);
}

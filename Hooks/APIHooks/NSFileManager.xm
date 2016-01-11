#import "../SharedDefine.pch"
%group NSFileManager
%hook NSFileManager

- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)contents attributes:(NSDictionary *) attributes {
	BOOL origResult = %orig(path, contents, attributes);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"createFileAtPath:contents:attributes:"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	[tracer addArgFromPlistObject:contents withKey:@"contents"];
	[tracer addArgFromPlistObject:attributes withKey:@"attributes"];
	[tracer addReturnValueFromPlistObject: [NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

- (NSData *)contentsAtPath:(NSString *)path {
	id origResult = %orig(path);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"contentsAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	[tracer addReturnValueFromPlistObject: origResult];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

- (id <NSObject, NSCopying, NSCoding>)ubiquityIdentityToken {
	id origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"ubiquityIdentityToken"];
	// Not sure about the return value, let's just store the pointer for now
	[tracer addReturnValueFromPlistObject:objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

%end
%end
extern void init_NSFileManager_hook(){
%init(NSFileManager);
}

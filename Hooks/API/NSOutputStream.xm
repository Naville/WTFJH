#import "../Utils/SQLiteStorage.h"
#import "../Utils/PlistObjectConverter.h"
#import "../Utils/CallStackInspector.h"
#import "../SharedDefine.pch"

%group NSOutputStream
%hook NSOutputStream


+ (id)outputStreamToFileAtPath:(NSString *)path append:(BOOL)shouldAppend {
	id origResult = %orig(path, shouldAppend);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSOutputStream" andMethod:@"outputStreamToFileAtPath:append:"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	[tracer addArgFromPlistObject:[NSNumber numberWithBool: shouldAppend] withKey:@"shouldAppend"];
	// Just store the pointer value for the return value
	[tracer addReturnValueFromPlistObject: objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

+ (id)outputStreamWithURL:(NSURL *)url append:(BOOL)shouldAppend {
	id origResult = %orig(url, shouldAppend);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSOutputStream" andMethod:@"outputStreamWithURL:append:"];
	[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: url] withKey:@"url"];
	[tracer addArgFromPlistObject:[NSNumber numberWithBool: shouldAppend] withKey:@"shouldAppend"];
	[tracer addReturnValueFromPlistObject: objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

- (id)initToFileAtPath:(NSString *)path append:(BOOL)shouldAppend {
	id origResult = %orig(path, shouldAppend);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSOutputStream" andMethod:@"initToFileAtPath:append:"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	[tracer addArgFromPlistObject:[NSNumber numberWithBool: shouldAppend] withKey:@"shouldAppend"];
	[tracer addReturnValueFromPlistObject: objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

- (id)initWithURL:(NSURL *)url append:(BOOL)shouldAppend {
	id origResult = %orig(url, shouldAppend);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSOutputStream" andMethod:@"initWithURL:append:"];
	[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: url] withKey:@"url"];
	[tracer addArgFromPlistObject:[NSNumber numberWithBool: shouldAppend] withKey:@"shouldAppend"];
	[tracer addReturnValueFromPlistObject: objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}


%end
%end
extern void init_NSOutputStream_hook(){
%init(NSOutputStream);
}

/* vim: set filetype=objc : */

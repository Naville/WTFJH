#import "../SharedDefine.pch"
%group NSFileManager
%hook NSFileManager

- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)contents attributes:(NSDictionary *) attributes {
	if([CallStackInspector wasDirectlyCalledByApp]){
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
	else{
		return %orig;
	}
}

- (NSData *)contentsAtPath:(NSString *)path {
	if([CallStackInspector wasDirectlyCalledByApp]){
	id origResult = %orig(path);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"contentsAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	[tracer addReturnValueFromPlistObject: origResult];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
	}
	else{
		return %orig;
	}
}

- (id)ubiquityIdentityToken {
	if([CallStackInspector wasDirectlyCalledByApp]){
	id origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"ubiquityIdentityToken"];
	[tracer addReturnValueFromPlistObject:objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
	}
	else{
		return %orig;
	}
}
- (BOOL)fileExistsAtPath:(NSString *)path{
	if([CallStackInspector wasDirectlyCalledByApp]){
	BOOL origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"fileExistsAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
	}else{
		return %orig;
	}

}
- (BOOL)isReadableFileAtPath:(NSString *)path{
	if([CallStackInspector wasDirectlyCalledByApp]){
	BOOL origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"isReadableFileAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
	}
	else{
		return %orig;
	}
}
- (BOOL)isWritableFileAtPath:(NSString *)path{
	if([CallStackInspector wasDirectlyCalledByApp]){
	BOOL origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"isWritableFileAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
	}
	else{
		return %orig;
	}
}
- (BOOL)isExecutableFileAtPath:(NSString *)path{
	if([CallStackInspector wasDirectlyCalledByApp]){
	BOOL origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"isExecutableFileAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}
else{
	return %orig;
}
}
- (BOOL)isDeletableFileAtPath:(NSString *)path{

	BOOL origResult = %orig;
if([CallStackInspector wasDirectlyCalledByApp]){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"isDeletableFileAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
	return origResult;	
}
- (NSDictionary*)attributesOfItemAtPath:(NSString *)path error:(NSError **)error{
	
	id origResult = %orig;
if([CallStackInspector wasDirectlyCalledByApp]){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"attributesOfItemAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addReturnValueFromPlistObject:origResult];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
	return origResult;		
}
- (NSDictionary *)attributesOfFileSystemForPath:(NSString *)path error:(NSError **)error{
		id origResult = %orig;
if([CallStackInspector wasDirectlyCalledByApp]){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"attributesOfFileSystemForPath:error:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addReturnValueFromPlistObject:origResult];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
	return origResult;	
}
- (BOOL)createSymbolicLinkAtPath:(NSString *)path withDestinationPath:(NSString *)destPath error:(NSError **)error{
	BOOL origResult = %orig;
if([CallStackInspector wasDirectlyCalledByApp]){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"createSymbolicLinkAtPath:withDestinationPath:error:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addArgFromPlistObject:destPath withKey:@"destPath"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
	return origResult;	
}
- (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary*)attributes error:(NSError **)error{
	BOOL origResult = %orig;
if([CallStackInspector wasDirectlyCalledByApp]){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"createDirectoryAtPath:withIntermediateDirectories:attributes:error:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addArgFromPlistObject:[NSNumber numberWithBool:createIntermediates] withKey:@"createIntermediates"];
	[tracer addArgFromPlistObject:attributes withKey:@"attributes"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
	return origResult;	

}
- (NSArray*)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error{
	
	id origResult = %orig;
if([CallStackInspector wasDirectlyCalledByApp]){
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileManager" andMethod:@"contentsOfDirectoryAtPath:error:"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addReturnValueFromPlistObject:origResult];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
	return origResult;	

}
%end
%end
extern void init_NSFileManager_hook(){
%init(NSFileManager);
}

#import "../SharedDefine.pch"
%group NSFileHandle
%hook NSFileHandle

- (NSData *)readDataToEndOfFile{
	id origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"readDataToEndOfFile"];
	[tracer addReturnValueFromPlistObject: origResult];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}
- (NSData *)readDataOfLength:(NSUInteger)length{
	id origResult = %orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"readDataOfLength:"];
	[tracer addArgFromPlistObject:[NSNumber numberWithLong:length] withKey:@"length"];
	[tracer addReturnValueFromPlistObject: origResult];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

- (void)writeData:(NSData *)data{
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"writeData:"];
	[tracer addArgFromPlistObject:data withKey:@"data"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	%orig(data);
}

- (unsigned long long)seekToEndOfFile{
	unsigned long long ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"seekToEndOfFile"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithUnsignedLongLong:ret]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;
}
- (void)seekToFileOffset:(unsigned long long)offset{
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"seekToFileOffset:"];
	[tracer addArgFromPlistObject:[NSNumber numberWithUnsignedLongLong:offset] withKey:@"offset"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	%orig(offset);
}

- (void)truncateFileAtOffset:(unsigned long long)offset{
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"truncateFileAtOffset:"];
	[tracer addArgFromPlistObject:[NSNumber numberWithUnsignedLongLong:offset] withKey:@"offset"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	%orig(offset);
}
- (void)synchronizeFile{
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"synchronizeFile"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
- (void)closeFile{
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"closeFile"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}

+ (id)fileHandleForReadingAtPath:(NSString *)path {
	id origResult = %orig(path);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"fileHandleForReadingAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	// Only store the value of the pointer for now. TODO: Convert NSFilehandle to Plist object
	// TODO: what do you want to parse what out of it? i.e., do you want to
	// actually make instance calls to the filehandle? to e.g., get the
	// data? [NSFileHandle readDataToEndOfFile]?
	[tracer addReturnValueFromPlistObject: objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

+ (id)fileHandleForReadingFromURL:(NSURL *)url error:(NSError **)error {
	id origResult = %orig(url, error);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"fileHandleForReadingFromURL:error:"];
	[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: url] withKey:@"url"];
	[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"error"];
	[tracer addReturnValueFromPlistObject:objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

+ (id)fileHandleForUpdatingAtPath:(NSString *)path {
	id origResult = %orig(path);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"fileHandleForUpdatingAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	[tracer addReturnValueFromPlistObject: objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

+ (id)fileHandleForUpdatingURL:(NSURL *)url error:(NSError **)error {
	id origResult = %orig(url, error);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"fileHandleForUpdatingURL:error:"];
	[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: url] withKey:@"url"];
	[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"error"];
	[tracer addReturnValueFromPlistObject:objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

+ (id)fileHandleForWritingAtPath:(NSString *)path {
	id origResult = %orig(path);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"fileHandleForWritingAtPath:"];
	[tracer addArgFromPlistObject:path withKey:@"path"];
	[tracer addReturnValueFromPlistObject: objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

+ (id)fileHandleForWritingToURL:(NSURL *)url error:(NSError **)error {
	id origResult = %orig(url, error);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSFileHandle" andMethod:@"fileHandleForWritingToURL:error:"];
	[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: url] withKey:@"url"];
	[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"error"];
	[tracer addReturnValueFromPlistObject:objectTypeNotSupported];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

%end

/* vim: set filetype=objc : */

%end
extern void init_NSFileHandle_hook(){
%init(NSFileHandle);
}

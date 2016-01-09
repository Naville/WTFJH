#import "../SharedDefine.pch"
%group NSURLConnection
%hook NSURLConnection
+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error {
	NSData *origResult = %orig(request, response, error);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLConnection" andMethod:@"sendSynchronousRequest:returningResponse:error:"];
	[tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLRequest:request] withKey:@"request"];
	[tracer addArgFromPlistObject:[RuntimeUtils propertyListForObject:*response] withKey:@"response"];
	[tracer addArgFromPlistObject:[RuntimeUtils propertyListForObject:*error] withKey:@"error"];
	[tracer addReturnValueFromPlistObject:origResult];
	SQLiteStorage* traceStorage=[SQLiteStorage sharedManager];
	[traceStorage saveTracedCall:tracer];
	[tracer release];
	return origResult;
}

%end
%end
extern void init_NSURLConnection_hook(){
%init(NSURLConnection);
}

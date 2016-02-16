#import "../SharedDefine.pch"
#import "../Utils/NSURLSessionDelegateProxy.h"
%group NSURLSession
%hook NSURLSession
+ (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(id)delegate delegateQueue:(NSOperationQueue *)queue{
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"sessionWithConfiguration:delegate:delegateQueue:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertURLSessionConfiguration:configuration] withKey:@"configuration"];
    [tracer addReturnValueFromPlistObject:objectTypeNotSupported];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    id NewDelegate=[[NSURLSessionDelegateProxy alloc]  initWithOriginalDelegate:delegate];
    return %orig(configuration,NewDelegate,queue);


}
- (void)finishTasksAndInvalidate {
    %orig;
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"finishTasksAndInvalidate"];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
}

- (void)invalidateAndCancel {
    %orig;
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"invalidateAndCancel"];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request {
    NSURLSessionDataTask *origResult = %orig(request);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"dataTaskWithRequest:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLRequest:request] withKey:@"request"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url {
    NSURLSessionDataTask *origResult = %orig(url);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"dataTaskWithURL:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertURL:url] withKey:@"url"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL {
    NSURLSessionUploadTask *origResult = %orig(request, fileURL);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"uploadTaskWithRequest:fromFile:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLRequest:request] withKey:@"request"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertURL:fileURL] withKey:@"fileURL"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData {
    NSURLSessionUploadTask *origResult = %orig(request, bodyData);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"uploadTaskWithRequest:fromData:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLRequest:request] withKey:@"request"];
    [tracer addArgFromPlistObject:bodyData withKey:@"bodyData"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request {
    NSURLSessionUploadTask *origResult = %orig(request);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"uploadTaskWithStreamedRequest:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLRequest:request] withKey:@"request"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request {
    NSURLSessionDownloadTask *origResult = %orig(request);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"downloadTaskWithRequest:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLRequest:request] withKey:@"request"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url {
    NSURLSessionDownloadTask *origResult = %orig(url);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"downloadTaskWithURL:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertURL:url] withKey:@"url"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData {
    NSURLSessionDownloadTask *origResult = %orig(resumeData);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"downloadTaskWithResumeData:"];
    [tracer addArgFromPlistObject:resumeData withKey:@"resumeData"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionStreamTask *)streamTaskWithHostName:(NSString *)hostname port:(NSInteger)port {
    NSURLSessionStreamTask *origResult = %orig(hostname, port);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"streamTaskWithHostName:port:"];
    [tracer addArgFromPlistObject:hostname withKey:@"hostname"];
    [tracer addArgFromPlistObject:[NSNumber numberWithInteger:port] withKey:@"port"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

- (NSURLSessionStreamTask *)streamTaskWithNetService:(NSNetService *)service {
    NSURLSessionStreamTask *origResult = %orig(service);
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSession" andMethod:@"streamTaskWithNetService:"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSNetService:service] withKey:@"service"];
    [tracer addReturnValueFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}

%end // End-Hook NSURLSession
%end // End-Group NSURLSession

extern void init_NSURLSession_hook() {
    %init(NSURLSession);
}

#import "NSURLSessionDelegateProxy.h"
@implementation NSURLSessionDelegateProxy


@synthesize originalDelegate;


- (id) initWithOriginalDelegate:(id)origDeleg {
    self = [super init];

    if (self) { // Store original delegate
        [self setOriginalDelegate:(origDeleg)];
    }
    return self;
}


- (BOOL)respondsToSelector:(SEL)aSelector {
    return [originalDelegate respondsToSelector:aSelector];
}


- (id)forwardingTargetForSelector:(SEL)sel {
    return originalDelegate;
}


- (void)dealloc {
    [originalDelegate release];
    [super dealloc];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                              didFinishDownloadingToURL:(NSURL *)location{
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSessionDelegate" andMethod:@"URLSession:downloadTask:didFinishDownloadingToURL:"];
    [tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"session"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:downloadTask] withKey:@"downloadTask"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertURL:location] withKey:@"location"];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    [originalDelegate URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];

}
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error{
  CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSessionDelegate" andMethod:@"URLSession:didBecomeInvalidWithError:"];
  [tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"session"];
  [tracer addArgFromPlistObject:[PlistObjectConverter convertNSError:error] withKey:@"error"];
  [traceStorage saveTracedCall:tracer];
  [tracer release];

  [originalDelegate URLSession:session didBecomeInvalidWithError:error];
}
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
  CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSessionDelegate" andMethod:@"URLSessionDidFinishEventsForBackgroundURLSession:"];
  [tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"session"];
  [traceStorage saveTracedCall:tracer];
  [tracer release];

  [originalDelegate URLSessionDidFinishEventsForBackgroundURLSession:session];  
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
  CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSessionDelegate" andMethod:@"URLSession:task:didCompleteWithError:"];
  [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:task] withKey:@"Task"];
  [tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"session"];
  [tracer addArgFromPlistObject:[PlistObjectConverter convertNSError:error] withKey:@"error"];
  [traceStorage saveTracedCall:tracer];
  [tracer release];
  [originalDelegate URLSession:session task:task didCompleteWithError:error];
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
  CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLSessionDelegate" andMethod:@"URLSession:dataTask:didReceiveData:"];
  [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLSessionTask:dataTask] withKey:@"Task"];
  [tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"session"];
  [tracer addArgFromPlistObject:data withKey:@"Data"];
  [traceStorage saveTracedCall:tracer];
  [tracer release];
  [originalDelegate URLSession:session dataTask:dataTask didReceiveData:data];

}
@end



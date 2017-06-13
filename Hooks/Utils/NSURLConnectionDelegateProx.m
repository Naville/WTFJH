
#import "NSURLConnectionDelegateProx.h"
#import "../Global.h"


@implementation NSURLConnectionDelegateProx{
  NSMutableData* responseData;
  NSString* originalDelegateName;
}


@synthesize originalDelegate;


- (NSURLConnectionDelegateProx*) initWithOriginalDelegate:(id)origDeleg {
    self = [super init];

    if (self) { // Store original delegate
        [self setOriginalDelegate:(origDeleg)];
        self->originalDelegateName=NSStringFromClass([origDeleg class]);
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


- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    id origResult = [originalDelegate connection:connection willCacheResponse:cachedResponse];
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLConnectionDelegate" andMethod:@"connection:willCacheResponse:"];
    [tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) connection] withKey:@"connection"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSCachedURLResponse: cachedResponse] withKey:@"cachedResponse"];
    [tracer addReturnValueFromPlistObject: [PlistObjectConverter convertNSCachedURLResponse:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}


- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
    id origResult = [originalDelegate connection:connection willSendRequest:request redirectResponse:redirectResponse];
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLConnectionDelegate" andMethod:@"connection:willSendRequest:redirectResponse:"];
    [tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) connection] withKey:@"connection"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLRequest:request] withKey:@"request"];
    [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLResponse:redirectResponse] withKey:@"redirectResponse"];
    [tracer addReturnValueFromPlistObject: [PlistObjectConverter convertNSURLRequest:origResult]];
    [traceStorage saveTracedCall:tracer];
    [tracer release];
    return origResult;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
  self->responseData=[NSMutableData new];
  [originalDelegate connection:connection didReceiveResponse:response];
  CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLConnectionDelegate" andMethod:@"connection:didReceiveResponse:"];
  [tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) connection] withKey:@"connection"];
  [tracer addArgFromPlistObject:[PlistObjectConverter convertNSURLResponse:response] withKey:@"response"];
  [traceStorage saveTracedCall:tracer];
  [tracer release];
  return;

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
  [self->responseData appendData:data];
  [originalDelegate connection:connection didReceiveData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
  [originalDelegate connectionDidFinishLoading:connection];
  CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLConnectionDelegate" andMethod:@"connectionDidFinishLoading:"];
  [tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) connection] withKey:@"connection"];
  [tracer addArgFromPlistObject:[self->responseData copy] withKey:@"Data"];
  [traceStorage saveTracedCall:tracer];
  [tracer release];
  [self->responseData release];
  return ;

}

/*- (nullable NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request;
- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
                                                 totalBytesWritten:(NSInteger)totalBytesWritten
                                         totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;
- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes;
- (void)connectionDidResumeDownloading:(NSURLConnection *)connection totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes;
- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *) destinationURL;*/

@end

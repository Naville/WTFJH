#import "../SharedDefine.pch"

%group NSURLConnection
%hook NSURLConnection

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error {
    NSData *origResult = %orig(request, response, error);
    if(WTShouldLog){
        WTInit(@"NSURLConnection",@"sendSynchronousRequest:returningResponse:error:");
        WTAdd([PlistObjectConverter convertNSURLRequest:request],@"request");
        if(response!=nil){
            WTAdd([PlistObjectConverter convertNSURLResponse:*response],@"response");
        }
        if(error!=nil){
            WTAdd([PlistObjectConverter convertNSError:*error],@"error");
        }
        WTReturn(origResult);
        WTSave;
        WTRelease;
    }
    return origResult;
}
+ (id)connectionWithRequest:(NSURLRequest *)request delegate:(id < NSURLConnectionDelegate >)delegate{
    id origResult;
    if(WTShouldLog){
        NSURLConnectionDelegateProx *delegateProxy = [[NSURLConnectionDelegateProx alloc] initWithOriginalDelegate:delegate];
        origResult = %orig(request, delegateProxy);

        WTInit(@"NSURLConnection",@"connectionWithRequest:delegate:");
        WTAdd([PlistObjectConverter convertNSURLRequest:request],@"request");
        WTAdd([PlistObjectConverter convertDelegate:delegate followingProtocol:@"NSURLConnectionDelegate"],@"delegate");
        WTReturn(objectTypeNotSupported);
        WTSave;
        WTRelease;
    }
    else{
        origResult = %orig;
    }
    return origResult;

}

- (id)initWithRequest:(NSURLRequest *)request delegate:(id < NSURLConnectionDelegate >)delegate {
    // Proxy the delegate so we can hook it
    id origResult;
    if(WTShouldLog){
        NSURLConnectionDelegateProx *delegateProxy = [[NSURLConnectionDelegateProx alloc] initWithOriginalDelegate:delegate];
        origResult = %orig(request, delegateProxy);

        WTInit(@"NSURLConnection",@"initWithRequest:delegate:");
        WTAdd([PlistObjectConverter convertNSURLRequest:request],@"request");
        WTAdd([PlistObjectConverter convertDelegate:delegate followingProtocol:@"NSURLConnectionDelegate"],@"delegate");
        WTReturn(objectTypeNotSupported);
        WTSave;
        WTRelease;
    }
    else{
        origResult = %orig;
    }
    return origResult;
}

- (id)initWithRequest:(NSURLRequest *)request delegate:(id < NSURLConnectionDelegate >)delegate startImmediately:(BOOL)startImmediately {
    id origResult;
    // Proxy the delegate so we can hook it
    if(WTShouldLog){
        NSURLConnectionDelegateProx *delegateProxy = [[NSURLConnectionDelegateProx alloc] initWithOriginalDelegate:delegate];
        origResult = %orig(request, delegateProxy, startImmediately);

        WTInit(@"NSURLConnection",@"initWithRequest:delegate:startImmediately:");
        WTAdd([PlistObjectConverter convertNSURLRequest:request],@"request");
        WTAdd([PlistObjectConverter convertDelegate:delegate followingProtocol:@"NSURLConnectionDelegate"],@"delegate");
        WTAdd([NSNumber numberWithBool:startImmediately] ,@"startImmediately");
        WTReturn(objectTypeNotSupported);
        WTSave;
        WTRelease;
        }
    else{
        origResult = %orig;  
    }
    return origResult;
}


// The following methods are not explicitely part of NSURLConnection.
// However, when implementing custom cert validation using the NSURLConnectionDelegate protocol,
// the application sends the result of the validation (server cert was OK/bad) to [challenge sender].
// The class of [challenge sender] is NSURLConnection because it implements the NSURLAuthenticationChallengeSender
// protocol. So we're hooking this in order to find when the validation might have been disabled.

// The usual way of disabling SSL cert validation
- (void)continueWithoutCredentialForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    %orig(challenge);
    WTInit(@"NSURLConnection",@"continueWithoutCredentialForAuthenticationChallenge:");
    WTAdd([PlistObjectConverter convertNSURLAuthenticationChallenge: challenge],@"challenge");
    WTSave;
    WTRelease;
    
}

// Might indicate client certificates or cert pinning. TODO: Investigate
- (void)useCredential:(NSURLCredential *)credential forAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    %orig(credential, challenge);
    WTInit(@"NSURLConnection",@"useCredential:forAuthenticationChallenge:");
    WTAdd([PlistObjectConverter convertNSURLCredential:credential],@"credential");
    WTAdd([PlistObjectConverter convertNSURLAuthenticationChallenge: challenge],@"challenge");
    WTSave;
    WTRelease;
    
}

%end
%end

extern void init_NSURLConnection_hook() {
    %init(NSURLConnection);
}

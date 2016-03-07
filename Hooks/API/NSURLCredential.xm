#import "../Utils/SQLiteStorage.h"
#import "../Utils/PlistObjectConverter.h"
#import "../Utils/CallStackInspector.h"
#import "../SharedDefine.pch"
%group NSURLCredential
%hook NSURLCredential

//credentialWithXXX() all call initWithXXX() so we don't hook them

- (id)initWithUser:(NSString *)user password:(NSString *)password persistence:(NSURLCredentialPersistence)persistence {
	id origResult = %orig(user, password, persistence);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLCredential" andMethod:@"initWithUser:password:persistence:"];
	[tracer addArgFromPlistObject:user withKey:@"user"];
	[tracer addArgFromPlistObject:password withKey:@"password"];
	[tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) persistence] withKey:@"persistence"];
	[tracer addReturnValueFromPlistObject: [PlistObjectConverter convertNSURLCredential:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}

- (id)initWithTrust:(SecTrustRef)trust {
	id origResult = %orig(trust);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLCredential" andMethod:@"initWithTrust:"];
	[tracer addArgFromPlistObject:[PlistObjectConverter convertSecTrustRef: trust] withKey:@"trust"];
	[tracer addReturnValueFromPlistObject: [PlistObjectConverter convertNSURLCredential:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}


// We probably don't need this as we can already see client cert stuff by hooking NSURLConnection
#if 0
- (id)initWithIdentity:(SecIdentityRef)identity certificates:(NSArray *)certArray persistence:(NSURLCredentialPersistence)persistence {
	id origResult = %orig(identity, certArray, persistence);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSURLCredential" andMethod:@"initWithIdentity:certificates:persistence:"];
	[tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) identity] withKey:@"identity"];
	[tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) certArray] withKey:@"certArray"];
	[tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) persistence] withKey:@"persistence"];
	[tracer addReturnValueFromPlistObject: [PlistObjectConverter convertNSURLCredential:origResult]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return origResult;
}
#endif

%end
%end
extern void init_NSURLCredential_hook(){
%init(NSURLCredential);
}
/* vim: set filetype=objc : */

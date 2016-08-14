#import "../SharedDefine.pch"
#import <dlfcn.h>
/*
Initially I was about to inspect CallStack and only intercept calls made by the app itself.
But meh that takes much more time and is probably useless under most circumstances. After all, no sane people would integrate Reveal in their release version. (* cough *)
So there you go.

*/






%group Reveal


%hook IBARevealLoader //To be honest, this one is more than enough.
+ (void)stopServer{
}
%end

//Just in case someone tried to stop the service using NSNotification or other ugly methods
%hook IBAWebSocket
- (void)stop{
}
%end



//Meh.Just in case
%hook IBANetService
- (void)stop{
}
%end

%hook IBANetServiceBrowser
- (void)stop{
}
%end

%hook IBAHTTPServer
- (void)stop{
}
%end






%end
extern void init_Reveal_hook() {
#ifndef NonJailbroken   

	dlopen("/usr/lib/libReveal.dylib",RTLD_NOW);
#elif 
	NSLog(@"Reveal Unsupported On Jailed Device");
#endif

    %init(Reveal);
}

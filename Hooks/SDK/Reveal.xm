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

	dlopen("/Library/MobileSubstrate/DynamicLibraries/libReveal.dylib", RTLD_NOW);
	//So we don't have to switch both WTFJH and RevealLoader on everytime.
	char * Err=dlerror();
	if (Err!=NULL){
		WTInit(@"WTFJH",@"Error");
		WTAdd([NSString stringWithUTF8String:Err],@"RevealLoadingError");
		WTSave;
		WTRelease;

	}

    %init(Reveal);
}

/*

From https://github.com/iosre/Notificatcher With Modifications


*/




#import "../SharedDefine.pch"

#include <notify.h>



%group Notification


%hook CPDistributedMessagingCenter
- (BOOL)_sendMessage:(id)arg1 userInfo:(id)arg2 receiveReply:(id)arg3 error:(id)arg4 toTarget:(id)arg5 selector:(SEL)arg6 context:(void*)arg7 nonBlocking:(BOOL)arg8
{
	BOOL ret=%orig;
	if(WTShouldLog){
	WTInit(@"CPDistributedMessagingCenter",@"_sendMessage:userInfo:receiveReply:error:toTarget:selector:context:nonBlocking:");
	WTAdd(arg1,@"Message");
	WTAdd(arg2,@"UserInfo");
	WTAdd(arg3,@"Reply");
	WTAdd(arg4,@"Error");
	WTAdd(arg5,@"Target");
	WTAdd(NSStringFromSelector(arg6),@"Target");
	WTAdd(objectTypeNotSupported,@"Error");
	WTReturn([NSNumber numberWithBool:ret]);
	WTSave;
	WTRelease;
	}
	return ret;
}
%end
%end

static uint32_t (*old_notify_post)(const char *name);

static uint32_t new_notify_post(const char *name)
{
	uint32_t result = old_notify_post(name);
	if(WTShouldLog){
	WTInit(@"notify_post",@"notify_post");
	WTAdd([NSString stringWithUTF8String:name],@"Name");
	WTReturn([NSNumber numberWithUnsignedInt:result]);
	WTSave;
	WTRelease;
	}
	return result;
}

extern "C" void _CFXNotificationPost(CFNotificationCenterRef center, NSNotification *notification, Boolean deliverImmediately);

static void (*old__CFXNotificationPost)(CFNotificationCenterRef center, NSNotification *notification, Boolean deliverImmediately);

static void new__CFXNotificationPost(CFNotificationCenterRef center, NSNotification *notification, Boolean deliverImmediately)
{
	old__CFXNotificationPost(center, notification, deliverImmediately);
	if(WTShouldLog){
	WTInit(@"CFXNotificationPost",@"CFXNotificationPost");
	WTAdd(notification.name,@"Name");
	WTAdd(objectTypeNotSupported,@"Object");
	WTAdd(notification.userInfo,@"UserInfo");
	WTSave;
	WTRelease;
	}
}
//extern "C" void _CFXNotificationRegisterObserver();

extern void init_Notification_hook() {
    %init(Notification);
    WTHookFunction((void*)notify_post, (void*)new_notify_post, (void**)&old_notify_post);
	WTHookFunction((void*)_CFXNotificationPost, (void*)new__CFXNotificationPost, (void**)&old__CFXNotificationPost);	
}

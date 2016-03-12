#import "../SharedDefine.pch"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

/*
FOUNDATION_EXPORT NSString *NSStringFromSelector(SEL aSelector);
FOUNDATION_EXPORT SEL NSSelectorFromString(NSString *aSelectorName);
*/
//Old Func Pointers
Class (*old_NSClassFromString)(NSString *aClassName);
NSString* (*old_NSStringFromClass)(Class aClass);
NSString* (*old_NSStringFromProtocol)(Protocol* proto);
Protocol* (*old_NSProtocolFromString)(NSString* namestr);


//New Func
Class new_NSClassFromString(NSString* aClassName){
	if(WTShouldLog){
		WTInit(@"ObjCRuntime",@"NSClassFromString");
		WTAdd(aClassName,@"ClassName");
		WTSave;
		WTRelease;	
	}
	return old_NSClassFromString(aClassName);
}
NSString* new_NSStringFromClass(Class aClass){
	NSString* orig=old_NSStringFromClass(aClass);
	if(WTShouldLog){
	WTInit(@"ObjCRuntime",@"NSStringFromClass");
	WTAdd(orig,@"ClassName");
	WTSave;
	WTRelease;
	}
	return orig;
}

NSString* new_NSStringFromProtocol(Protocol* proto){
	NSString* orig=old_NSStringFromProtocol(proto);
	if(WTShouldLog){
	WTInit(@"ObjCRuntime",@"NSStringFromProtocol");
	WTAdd(orig,@"ProtocalName");
	WTSave;
	WTRelease;
	}
	return orig;
}

Protocol* new_NSProtocolFromString(NSString* namestr){
	if(WTShouldLog){
		WTInit(@"ObjCRuntime",@"NSProtocolFromString");
		WTAdd(namestr,@"ProtocalName");
		WTSave;
		WTRelease;	
	}
	return old_NSProtocolFromString(namestr);
}

extern void init_ObjCRuntime_hook() {
   MSHookFunction((void*)NSClassFromString,(void*)new_NSClassFromString, (void**)&old_NSClassFromString);
   MSHookFunction((void*)NSStringFromClass,(void*)new_NSStringFromClass, (void**)&old_NSStringFromClass);
   MSHookFunction((void*)NSStringFromProtocol,(void*)new_NSStringFromProtocol, (void**)&old_NSStringFromProtocol);
   MSHookFunction((void*)NSProtocolFromString,(void*)new_NSProtocolFromString, (void**)&old_NSProtocolFromString);

}

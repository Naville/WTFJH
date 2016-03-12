#import "../SharedDefine.pch"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

/*
To Implement:
Class objc_getClass(const char *name)
const char *object_getClassName(id obj)
objc_getMetaClass(const char *name)
IMP class_getMethodImplementation(Class cls, SEL name) 
BOOL class_respondsToSelector(Class cls, SEL sel)
class_addMethod(Class cls, SEL name, IMP imp, 
                                 const char *types) 
class_replaceMethod(Class cls, SEL name, IMP imp, 
                                    const char *types) 

And Runtime Method Implementation Related Funcs


*/

//Old Func Pointers
Class (*old_NSClassFromString)(NSString *aClassName);
NSString* (*old_NSStringFromClass)(Class aClass);
NSString* (*old_NSStringFromProtocol)(Protocol* proto);
Protocol* (*old_NSProtocolFromString)(NSString* namestr);
NSString* (*old_NSStringFromSelector)(SEL aSelector);
SEL (*old_NSSelectorFromString)(NSString* aSelectorName);


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

NSString* new_NSStringFromSelector(SEL aSelector){
	NSString* orig=old_NSStringFromSelector(aSelector);
	if(WTShouldLog){
	WTInit(@"ObjCRuntime",@"NSStringFromSelector");
	WTAdd(orig,@"SelectorName");
	WTSave;
	WTRelease;
	}
	return orig;


}
SEL new_NSSelectorFromString(NSString* aSelectorName){
	if(WTShouldLog){
		WTInit(@"ObjCRuntime",@"NSSelectorFromString");
		WTAdd(aSelectorName,@"SelectorName");
		WTSave;
		WTRelease;	
	}
	return old_NSSelectorFromString(aSelectorName);

}

extern void init_ObjCRuntime_hook() {
   MSHookFunction((void*)NSClassFromString,(void*)new_NSClassFromString, (void**)&old_NSClassFromString);
   MSHookFunction((void*)NSStringFromClass,(void*)new_NSStringFromClass, (void**)&old_NSStringFromClass);
   MSHookFunction((void*)NSStringFromProtocol,(void*)new_NSStringFromProtocol, (void**)&old_NSStringFromProtocol);
   MSHookFunction((void*)NSProtocolFromString,(void*)new_NSProtocolFromString, (void**)&old_NSProtocolFromString);
   MSHookFunction((void*)NSStringFromSelector,(void*)new_NSStringFromSelector, (void**)&old_NSStringFromSelector);
   MSHookFunction((void*)NSSelectorFromString,(void*)new_NSSelectorFromString, (void**)&old_NSSelectorFromString);
}

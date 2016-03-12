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
BOOL (*old_class_addMethod)(Class cls, SEL name, IMP imp,const char *types);
BOOL (*old_class_addIvar)(Class cls, const char *name, size_t size,uint8_t alignment, const char *types);


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
BOOL new_class_addMethod(Class cls, SEL name, IMP imp,const char *types){
	if(WTShouldLog){
    NSString* TypeString=[NSString stringWithUTF8String:types];
    NSString* ClassName;
    NSString* SelectorName=NSStringFromSelector(name);
    NSString* IMPAddress=[NSString stringWithFormat:@"%p",imp];
    if(SelectorName!=nil&&[SelectorName isEqualToString:@""]==false){
        ClassName=NSStringFromClass(cls);
    }
    else{
        ClassName=@"WTFJH-UnknownClassName";
    }
    WTInit(@"ObjCRuntime",@"class_addMethod");
    WTAdd(TypeString,@"Type");
    WTAdd(ClassName,@"ClassName");
    WTAdd(SelectorName,@"SelectorName");
    WTAdd(IMPAddress,@"IMPAddress");
    WTSave;
    WTRelease;


    [TypeString release];
    [ClassName release];
    [SelectorName release];
    [IMPAddress release];
	}
    return old_class_addMethod(cls,name,imp,types);
    
}

BOOL new_class_addIvar(Class cls, const char *name, size_t size,uint8_t alignment, const char *types){
	if(WTShouldLog){
    NSString* ClassName=NSStringFromClass(cls);
    NSString* IvarName=[NSString stringWithUTF8String:name];
    NSString* Types=[NSString stringWithUTF8String:types];
    WTInit(@"ObjCRuntime",@"class_addIvar");
    WTAdd(ClassName,@"ClassName");
    WTAdd(IvarName,@"IvarName");
    WTAdd(Types,@"Types");
    WTSave;
    WTRelease;
    [ClassName release];
    [IvarName release];
    [Types release];
	}
    
    return old_class_addIvar(cls,name,size,alignment,types);
    
}

extern void init_ObjCRuntime_hook() {
   MSHookFunction((void*)NSClassFromString,(void*)new_NSClassFromString, (void**)&old_NSClassFromString);
   MSHookFunction((void*)NSStringFromClass,(void*)new_NSStringFromClass, (void**)&old_NSStringFromClass);
   MSHookFunction((void*)NSStringFromProtocol,(void*)new_NSStringFromProtocol, (void**)&old_NSStringFromProtocol);
   MSHookFunction((void*)NSProtocolFromString,(void*)new_NSProtocolFromString, (void**)&old_NSProtocolFromString);
   MSHookFunction((void*)NSStringFromSelector,(void*)new_NSStringFromSelector, (void**)&old_NSStringFromSelector);
   MSHookFunction((void*)NSSelectorFromString,(void*)new_NSSelectorFromString, (void**)&old_NSSelectorFromString);
   MSHookFunction((void*)class_addMethod,(void*)new_class_addMethod, (void**)&old_class_addMethod);
   MSHookFunction((void*)class_addIvar,(void*)new_class_addIvar, (void**)&old_class_addIvar);
}

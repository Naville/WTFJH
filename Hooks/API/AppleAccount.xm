#import "../Global.h"
%group AppleAccount

%hook AADeviceInfo
+ (id)productVersion{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"productVersion");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
+ (id)clientInfoHeader{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"clientInfoHeader");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
+ (id)apnsToken{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"apnsToken");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
+ (id)serialNumber{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"serialNumber");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
+ (id)osVersion{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"osVersion");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
+ (id)udid{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"udid");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
+ (id)signatureWithDictionary:(id)dictionary{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"signatureWithDictionary:");
	WTAdd(dictionary,@"dictionary");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
+ (id)infoDictionary{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"infoDictionary");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
- (id)mobileMeSetupToken{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"mobileMeSetupToken");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
- (id)regionCode{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"regionCode");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)buildVersion{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"buildVersion");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)osName{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"osName");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)productType{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"productType");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)productVersion{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"productVersion");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)wifiMacAddress{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"wifiMacAddress");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)serialNumber{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"serialNumber");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)osVersion{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"osVersion");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)lockDownValueForKey:(CFStringRef)key{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"lockDownValueForKey:");
	WTAdd((NSString*)key,@"Key");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)deviceInfoDictionary{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"deviceInfoDictionary");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
- (id)userAgentHeader{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"userAgentHeader");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)clientInfoHeader{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"clientInfoHeader");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	

}
- (id)appleIDClientIdentifier{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"appleIDClientIdentifier");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)modelNumber{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"modelNumber");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)deviceClass{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"deviceClass");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)storageCapacity{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"storageCapacity");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)internationalMobileEquipmentIdentity{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"internationalMobileEquipmentIdentity");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)mobileEquipmentIdentifier{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"mobileEquipmentIdentifier");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)deviceEnclosureColor{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"AADeviceInfo",@"deviceEnclosureColor");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
%end




%end

static void Loader(){
%init(AppleAccount);
}

WTCallBack(@"AppleAccount",Loader)
extern void init_AppleAccount_hook() {
    WTAddCallBack(Loader);
}

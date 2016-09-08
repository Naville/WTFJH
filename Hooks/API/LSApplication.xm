#import "../SharedDefine.pch"
#import <dlfcn.h>
%group LSApplication
%hook LSApplicationProxy
+ (id)applicationProxyForBundleURL:(id)arg1{
	id ret=%orig;
	if (WTShouldLog) {
		WTInit(@"LSApplicationProxy",@"applicationProxyForBundleURL:");
		WTAdd(arg1,@"BundleURL");
		WTReturn(ret);
		WTSave;
		WTRelease;
	}
	return ret;
}
+ (id)applicationProxyForIdentifier:(id)arg1{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"applicationProxyForIdentifier:");
	WTAdd(arg1,@"Identifier");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
+ (id)applicationProxyForItemID:(id)arg1{

	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"applicationProxyForItemID:");
	WTAdd(arg1,@"ItemID");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
+ (id)applicationProxyWithBundleUnitID:(unsigned long)arg1{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"applicationProxyWithBundleUnitID:");
	WTAdd([NSNumber numberWithUnsignedLong:arg1],@"BundleUnitID");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)VPNPlugins{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"VPNPlugins");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)appStoreReceiptURL{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"appStoreReceiptURL");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
- (id)appTags{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"appTags");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)applicationDSID{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"applicationDSID");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
- (id)applicationType{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"applicationType");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;


}
- (id)audioComponents{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"audioComponents");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

	
}
- (long)bundleModTime{
	long ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"bundleModTime");
	WTReturn([NSNumber numberWithLong:ret]);
	WTSave;
	WTRelease;
	}
	return ret;

}
- (id)deviceFamily{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"deviceFamily");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)deviceIdentifierForVendor{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"deviceIdentifierForVendor");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)directionsModes{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"directionsModes");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)dynamicDiskUsage{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"dynamicDiskUsage");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;
}
- (id)externalAccessoryProtocols{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"externalAccessoryProtocols");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
- (id)groupContainers{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"groupContainers");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)groupIdentifiers{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationProxy",@"groupIdentifiers");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
	
}
%end

%hook LSApplicationWorkspace
+ (id)defaultWorkspace{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationWorkspace",@"defaultWorkspace");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;


}

- (id)URLOverrideForURL:(id)arg1{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationWorkspace",@"URLOverrideForURL:");
	WTAdd(arg1,@"URL");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;

}
- (id)allApplications{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationWorkspace",@"allApplications");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (id)allInstalledApplications{
	id ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationWorkspace",@"allInstalledApplications");
	WTReturn(ret);
	WTSave;
	WTRelease;
	}
	return ret;	
}
- (void)_clearCachedAdvertisingIdentifier{
	%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationWorkspace",@"_clearCachedAdvertisingIdentifier");
	WTSave;
	WTRelease;
	}

}
- (void)_LSClearSchemaCaches{
	%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationWorkspace",@"_LSClearSchemaCaches");
	WTSave;
	WTRelease;
	}
}
- (BOOL)installApplication:(id)arg1 withOptions:(id)arg2{
	BOOL ret=%orig;
	if(WTShouldLog){
	WTInit(@"LSApplicationWorkspace",@"installApplication:withOptions:");
	WTAdd(arg1,@"Application");
	WTAdd(arg2,arg2);
	WTReturn([NSNumber numberWithBool:ret]);
	WTSave;
	WTRelease;
	}
	return ret;

}
%end



%end
extern void init_LSApplication_hook() {
dlopen("/System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices",RTLD_GLOBAL|RTLD_NOW);
%init(LSApplication);
  
  
}

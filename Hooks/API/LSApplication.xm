#import "../SharedDefine.pch"
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
/*
- (unsigned int)installType;
- (id)_initWithBundleUnit:(unsigned long)arg1 applicationIdentifier:(id)arg2;
- (id)itemID;
- (id)itemName;
- (id)localizedName;
- (id)localizedShortName;
- (id)machOUUIDs;
- (id)minimumSystemVersion;
- (id)plugInKitPlugins;
- (id)privateDocumentIconNames;
- (id)privateDocumentTypeOwner;
- (id)requiredDeviceCapabilities;
- (id)resourcesDirectoryURL;
- (id)roleIdentifier;
- (id)sdkVersion;
- (id)sourceAppIdentifier;
- (id)staticDiskUsage;
- (id)teamID;
- (id)userActivityStringForAdvertisementData:(id)arg1;
- (id)vendorName;*/
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
/*
- (BOOL)_LSPrivateRebuildApplicationDatabasesForSystemApps:(BOOL)arg1 internal:(BOOL)arg2 user:(BOOL)arg3;void)addObserver:(id)arg1;
- (id)applicationForOpeningResource:(id)arg1;
- (id)applicationForUserActivityDomainName:(id)arg1;
- (id)applicationForUserActivityType:(id)arg1;
- (BOOL)applicationIsInstalled:(id)arg1;
- (id)applicationsAvailableForHandlingURLScheme:(id)arg1;
- (id)applicationsAvailableForOpeningDocument:(id)arg1;
- (id)applicationsOfType:(unsigned int)arg1;
- (id)applicationsWithAudioComponents;
- (id)applicationsWithExternalAccessoryProtocols;
- (id)applicationsWithSettingsBundle;
- (id)applicationsWithUIBackgroundModes;
- (id)applicationsWithVPNPlugins;
- (void)clearAdvertisingIdentifier;
- (void)clearCreatedProgressForBundleID:(id)arg1;
- (id)delegateProxy;
- (id)deviceIdentifierForAdvertising;
- (id)deviceIdentifierForVendor;
- (id)directionsApplications;
- (BOOL)establishConnection;
- (BOOL)getClaimedActivityTypes:(id*)arg1 domains:(id*)arg2;
- (void)getKnowledgeUUID:(id*)arg1 andSequenceNumber:(id*)arg2;
- (BOOL)installApplication:(id)arg1 withOptions:(id)arg2;
- (BOOL)installPhaseFinishedForProgress:(id)arg1;
- (id)installProgressForApplication:(id)arg1 withPhase:(unsigned int)arg2;
- (id)installProgressForBundleID:(id)arg1 makeSynchronous:(unsigned char)arg2;
- (id)installedPlugins;
- (id)installedVPNPlugins;
- (BOOL)invalidateIconCache:(id)arg1;
- (BOOL)openApplicationWithBundleID:(id)arg1;
- (BOOL)openSensitiveURL:(id)arg1 withOptions:(id)arg2;
- (BOOL)openURL:(id)arg1;
- (BOOL)openURL:(id)arg1 withOptions:(id)arg2;
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 sourceIsManaged:(BOOL)arg4 userInfo:(id)arg5 delegate:(id)arg6;
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 userInfo:(id)arg4;
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 userInfo:(id)arg4 delegate:(id)arg5;
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 userInfo:(id)arg3;
- (id)placeholderApplications;
- (id)pluginsWithIdentifiers:(id)arg1 protocols:(id)arg2 version:(id)arg3;
- (id)privateURLSchemes;
- (id)publicURLSchemes;
- (BOOL)registerApplication:(id)arg1;
- (BOOL)registerApplicationDictionary:(id)arg1;
- (BOOL)registerApplicationDictionary:(id)arg1 withObserverNotification:(unsigned int)arg2;
- (BOOL)registerPlugin:(id)arg1;
- (id)remoteObserver;
- (void)removeInstallProgressForBundleID:(id)arg1;
- (void)removeObserver:(id)arg1;
- (BOOL)uninstallApplication:(id)arg1 withOptions:(id)arg2;
- (BOOL)unregisterApplication:(id)arg1;
- (BOOL)unregisterPlugin:(id)arg1;
- (id)unrestrictedApplications;
- (BOOL)updateSINFWithData:(id)arg1 forApplication:(id)arg2 options:(id)arg3 error:(id*)arg4;
%end
%hook LSBundleProxy
+ (id)bundleProxyForIdentifier:(id)arg1;
+ (id)bundleProxyForURL:(id)arg1;

- (id)_plistValueForKey:(id)arg1;
- (id)appStoreReceiptURL;
- (id)bundleContainerURL;
- (id)bundleExecutable;
- (id)bundleIdentifier;
- (id)bundleType;
- (id)bundleURL;
- (id)bundleVersion;
- (id)cacheGUID;
- (id)containerURL;
- (id)dataContainerURL;
- (id)entitlements;
- (id)environmentVariables;
- (BOOL)foundBackingBundle;
- (id)groupContainerURLs;
- (id)machOUUIDs;
- (unsigned int)sequenceNumber;
- (void)setLocalizedShortName:(NSString *)arg1;
- (id)signerIdentity;*/
%end



%end
static void Loader(){
%init(LSApplication);

}
WTCallBack(@"MobileCoreServices",Loader)
extern void init_LSApplication_hook() {
WTAddCallBack(Loader);
  
}

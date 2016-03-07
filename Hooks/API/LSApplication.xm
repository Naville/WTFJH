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
/*
+ (id)applicationProxyForItemID:(id)arg1;
+ (id)applicationProxyWithBundleUnitID:(unsigned long)arg1;
- (id)VPNPlugins;
- (id)_initWithBundleUnit:(unsigned long)arg1 applicationIdentifier:(id)arg2;
- (id)appStoreReceiptURL;
- (id)appTags;
- (id)applicationDSID;
- (id)applicationType;
- (id)audioComponents;
- (long)bundleModTime;
- (id)description;
- (id)deviceFamily;
- (id)deviceIdentifierForVendor;
- (id)directionsModes;
- (id)dynamicDiskUsage;
- (id)externalAccessoryProtocols;
- (id)groupContainers;
- (id)groupIdentifiers;
- (unsigned int)installType;
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
- (id)vendorName;
%end
%hook LSApplicationWorkspace
+ (id)defaultWorkspace;

- (id)URLOverrideForURL:(id)arg1;
- (void)_LSClearSchemaCaches;
- (BOOL)_LSPrivateRebuildApplicationDatabasesForSystemApps:(BOOL)arg1 internal:(BOOL)arg2 user:(BOOL)arg3;
- (void)_clearCachedAdvertisingIdentifier;
- (void)addObserver:(id)arg1;
- (id)allApplications;
- (id)allInstalledApplications;
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
WTAddCallBack;
  
}

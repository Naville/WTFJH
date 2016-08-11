#import "./Hooks/Obfuscation.h"
void GlobalInit() {
extern BOOL getBoolFromPreferences(NSString *preferenceValue);
if (getBoolFromPreferences(@"AppleAccount") == YES) {
NSLog(@"AppleAccountInit");
extern void init_AppleAccount_hook();
    init_AppleAccount_hook();
}
if (getBoolFromPreferences(@"CommonCryptor") == YES) {
NSLog(@"CommonCryptorInit");
extern void init_CommonCryptor_hook();
    init_CommonCryptor_hook();
}
if (getBoolFromPreferences(@"CommonDigest") == YES) {
NSLog(@"CommonDigestInit");
extern void init_CommonDigest_hook();
    init_CommonDigest_hook();
}
if (getBoolFromPreferences(@"CommonHMAC") == YES) {
NSLog(@"CommonHMACInit");
extern void init_CommonHMAC_hook();
    init_CommonHMAC_hook();
}
if (getBoolFromPreferences(@"CommonKeyDerivation") == YES) {
NSLog(@"CommonKeyDerivationInit");
extern void init_CommonKeyDerivation_hook();
    init_CommonKeyDerivation_hook();
}
if (getBoolFromPreferences(@"CoreTelephony") == YES) {
NSLog(@"CoreTelephonyInit");
extern void init_CoreTelephony_hook();
    init_CoreTelephony_hook();
}
if (getBoolFromPreferences(@"dlfcn") == YES) {
NSLog(@"dlfcnInit");
extern void init_dlfcn_hook();
    init_dlfcn_hook();
}
if (getBoolFromPreferences(@"Keychain") == YES) {
NSLog(@"KeychainInit");
extern void init_Keychain_hook();
    init_Keychain_hook();
}
if (getBoolFromPreferences(@"libC") == YES) {
NSLog(@"libCInit");
extern void init_libC_hook();
    init_libC_hook();
}
if (getBoolFromPreferences(@"libMobileGestalt") == YES) {
NSLog(@"libMobileGestaltInit");
extern void init_libMobileGestalt_hook();
    init_libMobileGestalt_hook();
}
if (getBoolFromPreferences(@"LSApplication") == YES) {
NSLog(@"LSApplicationInit");
extern void init_LSApplication_hook();
    init_LSApplication_hook();
}
if (getBoolFromPreferences(@"MachO") == YES) {
NSLog(@"MachOInit");
extern void init_MachO_hook();
    init_MachO_hook();
}
if (getBoolFromPreferences(@"Notification") == YES) {
NSLog(@"NotificationInit");
extern void init_Notification_hook();
    init_Notification_hook();
}
if (getBoolFromPreferences(@"NSData") == YES) {
NSLog(@"NSDataInit");
extern void init_NSData_hook();
    init_NSData_hook();
}
if (getBoolFromPreferences(@"NSFileHandle") == YES) {
NSLog(@"NSFileHandleInit");
extern void init_NSFileHandle_hook();
    init_NSFileHandle_hook();
}
if (getBoolFromPreferences(@"NSFileManager") == YES) {
NSLog(@"NSFileManagerInit");
extern void init_NSFileManager_hook();
    init_NSFileManager_hook();
}
if (getBoolFromPreferences(@"NSHTTPCookie") == YES) {
NSLog(@"NSHTTPCookieInit");
extern void init_NSHTTPCookie_hook();
    init_NSHTTPCookie_hook();
}
if (getBoolFromPreferences(@"NSInputStream") == YES) {
NSLog(@"NSInputStreamInit");
extern void init_NSInputStream_hook();
    init_NSInputStream_hook();
}
if (getBoolFromPreferences(@"NSKeyedArchiver") == YES) {
NSLog(@"NSKeyedArchiverInit");
extern void init_NSKeyedArchiver_hook();
    init_NSKeyedArchiver_hook();
}
if (getBoolFromPreferences(@"NSKeyedUnarchiver") == YES) {
NSLog(@"NSKeyedUnarchiverInit");
extern void init_NSKeyedUnarchiver_hook();
    init_NSKeyedUnarchiver_hook();
}
if (getBoolFromPreferences(@"NSOutputStream") == YES) {
NSLog(@"NSOutputStreamInit");
extern void init_NSOutputStream_hook();
    init_NSOutputStream_hook();
}
if (getBoolFromPreferences(@"NSProcessInfo") == YES) {
NSLog(@"NSProcessInfoInit");
extern void init_NSProcessInfo_hook();
    init_NSProcessInfo_hook();
}
if (getBoolFromPreferences(@"NSURLConnection") == YES) {
NSLog(@"NSURLConnectionInit");
extern void init_NSURLConnection_hook();
    init_NSURLConnection_hook();
}
if (getBoolFromPreferences(@"NSURLCredential") == YES) {
NSLog(@"NSURLCredentialInit");
extern void init_NSURLCredential_hook();
    init_NSURLCredential_hook();
}
if (getBoolFromPreferences(@"NSURLSession") == YES) {
NSLog(@"NSURLSessionInit");
extern void init_NSURLSession_hook();
    init_NSURLSession_hook();
}
if (getBoolFromPreferences(@"NSUserDefaults") == YES) {
NSLog(@"NSUserDefaultsInit");
extern void init_NSUserDefaults_hook();
    init_NSUserDefaults_hook();
}
if (getBoolFromPreferences(@"NSXMLParser") == YES) {
NSLog(@"NSXMLParserInit");
extern void init_NSXMLParser_hook();
    init_NSXMLParser_hook();
}
if (getBoolFromPreferences(@"ObjCRuntime") == YES) {
NSLog(@"ObjCRuntimeInit");
extern void init_ObjCRuntime_hook();
    init_ObjCRuntime_hook();
}
if (getBoolFromPreferences(@"Security") == YES) {
NSLog(@"SecurityInit");
extern void init_Security_hook();
    init_Security_hook();
}
if (getBoolFromPreferences(@"Socket") == YES) {
NSLog(@"SocketInit");
extern void init_Socket_hook();
    init_Socket_hook();
}
if (getBoolFromPreferences(@"SSLKillSwitch") == YES) {
NSLog(@"SSLKillSwitchInit");
extern void init_SSLKillSwitch_hook();
    init_SSLKillSwitch_hook();
}
if (getBoolFromPreferences(@"sysctl") == YES) {
NSLog(@"sysctlInit");
extern void init_sysctl_hook();
    init_sysctl_hook();
}
if (getBoolFromPreferences(@"UIPasteboard") == YES) {
NSLog(@"UIPasteboardInit");
extern void init_UIPasteboard_hook();
    init_UIPasteboard_hook();
}
if (getBoolFromPreferences(@"FclBlowfish") == YES) {
NSLog(@"FclBlowfishInit");
extern void init_FclBlowfish_hook();
    init_FclBlowfish_hook();
}
if (getBoolFromPreferences(@"JSPatch") == YES) {
NSLog(@"JSPatchInit");
extern void init_JSPatch_hook();
    init_JSPatch_hook();
}
if (getBoolFromPreferences(@"OpenSSLAES") == YES) {
NSLog(@"OpenSSLAESInit");
extern void init_OpenSSLAES_hook();
    init_OpenSSLAES_hook();
}
if (getBoolFromPreferences(@"OpenSSLBlowFish") == YES) {
NSLog(@"OpenSSLBlowFishInit");
extern void init_OpenSSLBlowFish_hook();
    init_OpenSSLBlowFish_hook();
}
if (getBoolFromPreferences(@"OpenSSLMD5") == YES) {
NSLog(@"OpenSSLMD5Init");
extern void init_OpenSSLMD5_hook();
    init_OpenSSLMD5_hook();
}
if (getBoolFromPreferences(@"OpenSSLSHA1") == YES) {
NSLog(@"OpenSSLSHA1Init");
extern void init_OpenSSLSHA1_hook();
    init_OpenSSLSHA1_hook();
}
if (getBoolFromPreferences(@"OpenSSLSHA512") == YES) {
NSLog(@"OpenSSLSHA512Init");
extern void init_OpenSSLSHA512_hook();
    init_OpenSSLSHA512_hook();
}
if (getBoolFromPreferences(@"Reveal") == YES) {
NSLog(@"RevealInit");
extern void init_Reveal_hook();
    init_Reveal_hook();
}
if (getBoolFromPreferences(@"Wax") == YES) {
NSLog(@"WaxInit");
extern void init_Wax_hook();
    init_Wax_hook();
}
if (getBoolFromPreferences(@"classdumpdyld") == YES) {
NSLog(@"classdumpdyldInit");
extern void init_classdumpdyld_hook();
    init_classdumpdyld_hook();
}
if (getBoolFromPreferences(@"dumpdecrypted") == YES) {
NSLog(@"dumpdecryptedInit");
extern void init_dumpdecrypted_hook();
    init_dumpdecrypted_hook();
}
if (getBoolFromPreferences(@"InspectiveC") == YES) {
NSLog(@"InspectiveCInit");
extern void init_InspectiveC_hook();
    init_InspectiveC_hook();
}
if (getBoolFromPreferences(@"Cycript") == YES) {
NSLog(@"CycriptInit");
extern void init_Cycript_hook();
    init_Cycript_hook();
}
if (getBoolFromPreferences(@"RemoveASLR") == YES) {
NSLog(@"RemoveASLRInit");
extern void init_RemoveASLR_hook();
    init_RemoveASLR_hook();
}
NSLog(@"Finished Init Modules");
}

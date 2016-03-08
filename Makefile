export CFLAGS=-Wp,"-DWTFJHTWEAKNAME=@\"Q6KXCIVUHHMN22U\""
include theos/makefiles/common.mk
export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:7.0:7.0
TWEAK_NAME = Q6KXCIVUHHMN22U
Q6KXCIVUHHMN22U_FILES = Tweak.xm CompileDefines.xm Hooks/API/AntiAntiDebugging.xm Hooks/API/CommonCryptor.xm Hooks/API/CommonDigest.xm Hooks/API/CommonHMAC.xm Hooks/API/CommonKeyDerivation.xm Hooks/API/CoreTelephony.xm Hooks/API/dlfcn.xm Hooks/API/Keychain.xm Hooks/API/libC.xm Hooks/API/libMobileGestalt.xm Hooks/API/LSApplication.xm Hooks/API/NSData.xm Hooks/API/NSFileHandle.xm Hooks/API/NSFileManager.xm Hooks/API/NSHTTPCookie.xm Hooks/API/NSInputStream.xm Hooks/API/NSKeyedArchiver.xm Hooks/API/NSKeyedUnarchiver.xm Hooks/API/NSOutputStream.xm Hooks/API/NSProcessInfo.xm Hooks/API/NSURLConnection.xm Hooks/API/NSURLCredential.xm Hooks/API/NSURLSession.xm Hooks/API/NSUserDefaults.xm Hooks/API/NSXMLParser.xm Hooks/API/Security.xm Hooks/API/SSLKillSwitch.xm Hooks/API/sysctl.xm Hooks/API/UIPasteboard.xm Hooks/SDK/FclBlowfish.xm Hooks/SDK/JSPatch.xm Hooks/SDK/OpenSSLAES.xm Hooks/SDK/OpenSSLBlowFish.xm Hooks/SDK/OpenSSLMD5.xm Hooks/SDK/OpenSSLSHA1.xm Hooks/SDK/OpenSSLSHA512.xm Hooks/SDK/Wax.xm Hooks/Utils/CallStackInspector.m Hooks/Utils/CallTracer.m Hooks/Utils/DelegateProxies.m Hooks/Utils/NSURLConnectionDelegateProx.m Hooks/Utils/NSURLSessionDelegateProxy.m Hooks/Utils/PlistObjectConverter.m Hooks/Utils/RuntimeUtils.m Hooks/Utils/SQLiteStorage.m Hooks/Utils/Utils.m Hooks/ThirdPartyTools/DeviceIDFake.xm Hooks/ThirdPartyTools/InspectiveC.xm Hooks/ThirdPartyTools/RuntimeClassDump.xm
ADDITIONAL_CCFLAGS  = -Qunused-arguments
ADDITIONAL_LDFLAGS  = -Wl,-segalign,4000,-sectcreate,WTFJH,SIGDB,./SignatureDatabase.plist,-sectcreate,WTFJH,DeviceIDFake,./DeviceIDFake.dylib,-sectcreate,WTFJH,InspectiveC,./InspectiveC.dylib,-sectcreate,WTFJH,RuntimeClassDump,./RuntimeClassDump.dylib
Q6KXCIVUHHMN22U_LIBRARIES = sqlite3 substrate
Q6KXCIVUHHMN22U_FRAMEWORKS = Foundation UIKit Security
include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
	install.exec "killall -9 SpringBoard"
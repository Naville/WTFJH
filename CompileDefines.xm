void GlobalInit(){
extern BOOL getBoolFromPreferences(NSString *preferenceValue);
if(getBoolFromPreferences(@"NSData")==YES){
extern  void init_NSData_hook();
init_NSData_hook();
}
if(getBoolFromPreferences(@"NSURLConnection")==YES){
extern  void init_NSURLConnection_hook();
init_NSURLConnection_hook();
}
if(getBoolFromPreferences(@"OpenSSL")==YES){
extern  void init_OpenSSL_hook();
init_OpenSSL_hook();
}
}

#import "../SharedDefine.pch"
%group NSURLConnection
%hook NSURLConnection
+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error {

}

%end
%end
extern void init_NSURLConnection_hook(){
%init(NSURLConnection);
}

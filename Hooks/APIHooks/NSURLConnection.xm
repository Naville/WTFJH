#import "../SharedDefine.pch"
%group NSURLConnection
//Insert Your Hook Here
%end
extern void init_NSURLConnection_hook(){
%init(NSURLConnection);
}

#import "../SharedDefine.pch"
#define Port 2588
extern void CYListenServer(short port);
extern void init_Cycript_hook() {
    CYListenServer(Port);
    NSLog(@"Cycript Server At %i",Port);
    //Shall We Inform DeviceIP and Port Through GUI?
}

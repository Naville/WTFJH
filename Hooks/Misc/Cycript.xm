#import "../SharedDefine.pch"
extern void CYListenServer(short port);
extern void init_Cycript_hook() {
    CYListenServer(CyPort);
    NSLog(@"Cycript Server At %i",CyPort);
    //Shall We Inform DeviceIP and Port Through GUI?
}

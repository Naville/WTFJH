#import "../SharedDefine.pch"

//extern void CYListenServer(short port);
typedef void (*CYListenServer)(short port);  
static CYListenServer CYListenServerFuncPointer;
extern void init_Cycript_hook() {
	void* Handle=dlopen(NULL,RTLD_GLOBAL | RTLD_NOW);
	CYListenServerFuncPointer=(CYListenServer)dlsym(Handle,"_CYListenServer");
	dlclose(Handle);
	//Fuck Theos
	if(CYListenServerFuncPointer!=NULL){
    CYListenServerFuncPointer(CyPort);
    NSLog(@"Cycript Server At %i",CyPort);
	}
	else{
		NSLog(@"Cycript Failed To Start");
	}

    //Shall We Inform DeviceIP and Port Through GUI?
}

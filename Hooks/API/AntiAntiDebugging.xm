#import "../SharedDefine.pch"
#import <sys/sysctl.h>

//sysctl Anti-Debugging Hook is Moved into sysctl.xm
static int (*oldptrace)(int _request, pid_t _pid, caddr_t _addr, int _data);
static int (*oldsyscall)(long request, long pid, long addr, long data);
static int newptrace(int _request, pid_t _pid, caddr_t _addr, int _data){
if (_request == 31) {
_request = 1;
}
return oldptrace(_request,_pid,_addr,_data);
}


static int newsyscall(long request, long pid, long addr, long data) {
if (request == 26) {
return 0;
}
return oldsyscall(request,pid,addr,data);
}
extern void init_AntiAntiDebugging_hook() {
	MSHookFunction((void *)MSFindSymbol(NULL,"_ptrace"), (void *)newptrace, (void **)&oldptrace);
	MSHookFunction((void *)MSFindSymbol(NULL,"_syscall"),(void *)newsyscall,(void **)&oldsyscall);
}

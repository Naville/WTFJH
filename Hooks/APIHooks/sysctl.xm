#import "../SharedDefine.pch"
#import <sys/sysctl.h>
static NSArray* HWArgs=@[
@"WTFJH-Undefined",
@"HW_MACHINE",
@"HW_MODEL",
@"HW_NCPU",
@"HW_BYTEORDER",
@"HW_PHYSMEM",
@"HW_USERMEM",
@"HW_PAGESIZE",
@"HW_DISKNAMES",
@"HW_DISKSTATS",
@"HW_EPOCH",
@"HW_FLOATINGPT",
@"HW_MACHINE_ARCH",
@"HW_VECTORUNIT",
@"HW_BUS_FREQ",
@"HW_CPU_FREQ",
@"HW_CACHELINE",
@"HW_L1ICACHESIZE",
@"HW_L1DCACHESIZE",
@"HW_L2SETTINGS",
@"HW_L2CACHESIZE",
@"HW_L3SETTINGS",
@"HW_L3CACHESIZE",
@"HW_TB_FREQ",
@"HW_MEMSIZE",
@"HW_AVAILCPU",
@"HW_MAXID"];
/*
int	sysctlnametomib(const char *, int *, size_t *);//Probably Pointless To Hook
*/
int (*old_sysctl)(int *, u_int, void *, size_t *, void *, size_t);
int	(*old_sysctlbyname)(const char *, void *, size_t *, void *, size_t);
int	new_sysctlbyname(const char *name, void *oldp, size_t *oldlenp, void *newp, size_t newlen){
	if([CallStackInspector wasDirectlyCalledByApp]){

		NSString* nameStr=[NSString stringWithUTF8String:name];
		int ret=old_sysctlbyname(name,oldp,oldlenp,newp,newlen);
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"sysctl" andMethod:@"sysctlbyname"];
		[tracer addArgFromPlistObject:nameStr withKey:@"name"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt:ret]];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		[nameStr release];
		return ret;
	}
	else{
		return old_sysctlbyname(name,oldp,oldlenp,newp,newlen);
	}

}
int new_sysctl(int *name, u_int namelen, void *oldp, size_t *oldlenp, void *newp, size_t newlen){
	if([CallStackInspector wasDirectlyCalledByApp]){
	NSMutableArray* names=[NSMutableArray array];
	for(int x=0;x<namelen-1;x++){
		[names addObject:HWArgs[name[x]]];

	}
	int ret= old_sysctl(name,namelen,oldp,oldlenp,newp,newlen);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"sysctl" andMethod:@"sysctl"];
	[tracer addArgFromPlistObject:names withKey:@"name"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt:ret]];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	[names release];
	return ret;
		}
else{

	return old_sysctl(name,namelen,oldp,oldlenp,newp,newlen);
}
}

extern void init_sysctl_hook() {
   MSHookFunction((void *) sysctlbyname,(void *)new_sysctlbyname,(void **) &old_sysctlbyname);
   MSHookFunction((void *) sysctl,(void *)new_sysctl,(void **) &old_sysctl);
}

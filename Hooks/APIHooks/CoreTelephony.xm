#import "../SharedDefine.pch"
struct CTResult
{
    int flag;
    int a;
};

struct __CTServerConnection {
  int a;
  int b;
  CFMachPortRef myport;
  int c;
  int d;
  int e;
  int f;
  int g;
  int h;
  int i;
};
typedef struct __CTServerConnection CTServerConnection;
typedef CTServerConnection* CTServerConnectionRef;

struct __CellInfo {
  int servingmnc;
  int network;
  int location;
  int cellid;
  int station;
  int freq;
  int rxlevel;
  int c1;
  int c2;
};
typedef struct __CellInfo CellInfo;
typedef CellInfo* CellInfoRef;
%group CoreTelephony
%hook CTAsciiAddress
+ (id)asciiAddressWithString:(id)arg1{
	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CTAsciiAddress" andMethod:@"asciiAddressWithString:"];
	[tracer addArgFromPlistObject:arg1 withKey:@"arg1"];
	[tracer addReturnValueFromPlistObject: ret];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;
}

- (id)canonicalFormat{
	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CTAsciiAddress" andMethod:@"canonicalFormat"];
	[tracer addReturnValueFromPlistObject: ret];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;
}
- (id)address{
	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CTAsciiAddress" andMethod:@"address"];
	[tracer addReturnValueFromPlistObject: ret];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;
}
- (id)initWithAddress:(id)arg1{
	id ret=%orig;
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CTAsciiAddress" andMethod:@"initWithAddress"];
	[tracer addArgFromPlistObject:arg1 withKey:@"arg1"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;
}
%end
%end
int* (*old_CTServerConnectionCopyMobileEquipmentInfo)(struct CTResult * Status,struct __CTServerConnection * Connection,CFMutableDictionaryRef * Dictionary);
int* new_CTServerConnectionCopyMobileEquipmentInfo(struct CTResult * Status,
												struct __CTServerConnection * Connection,
												CFMutableDictionaryRef * Dictionary){
		int* retValue=old_CTServerConnectionCopyMobileEquipmentInfo(Status,Connection,Dictionary);
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CTAsciiAddress" andMethod:@"_CTServerConnectionCopyMobileEquipmentInfo"];
		[tracer addArgFromPlistObject:(__bridge NSDictionary*)*Dictionary withKey:@"Dictionary"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInt:Status->flag] withKey:@"CTResult->flag"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInt:Status->a] withKey:@"CTResult->a"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt:*retValue]];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		return retValue;

}
void (*old_CTServerConnectionCellMonitorGetCellCount)(CFMachPortRef port,CTServerConnectionRef CRef,int *cellinfo_count);
void _CTServerConnectionCellMonitorGetCellCount(CFMachPortRef port,CTServerConnectionRef CRef,int *cellinfo_count){
	old_CTServerConnectionCellMonitorGetCellCount(port,CRef,cellinfo_count);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CTAsciiAddress" andMethod:@"_CTServerConnectionCellMonitorGetCellCount"];
	[tracer addArgFromPlistObject:[NSNumber numberWithInt:*cellinfo_count] withKey:@"cellinfo_count"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
void (*old_CTServerConnectionCellMonitorGetCellInfo)(CFMachPortRef port,CTServerConnectionRef,int cellinfo_number,CellInfoRef* ref);
void _CTServerConnectionCellMonitorGetCellInfo(CFMachPortRef port,CTServerConnectionRef CRef,int cellinfo_number,CellInfoRef* ref){
	old_CTServerConnectionCellMonitorGetCellInfo(port,CRef,cellinfo_number,ref);
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CTAsciiAddress" andMethod:@"_CTServerConnectionCellMonitorGetCellInfo"];
	[tracer addArgFromPlistObject:[NSNumber numberWithInt:cellinfo_number] withKey:@"cellinfo_number"];
	struct __CellInfo* info=*ref;
	[tracer addArgFromPlistObject:@{@"servingmnc":[NSNumber numberWithInt:info->servingmnc],
					@"location":[NSNumber numberWithInt:info->location],
					@"cellid":[NSNumber numberWithInt:info->cellid],
					@"station":[NSNumber numberWithInt:info->station],
					@"freq":[NSNumber numberWithInt:info->freq],
					@"rxlevel":[NSNumber numberWithInt:info->rxlevel],
					@"c1":[NSNumber numberWithInt:info->c1],
					@"c2":[NSNumber numberWithInt:info->c2],
					@"network":[NSNumber numberWithInt:info->network]
					} 
					withKey:@"CellInfo"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
}
/*
typedef void (*CTServerConnectionCallback)(CTServerConnectionRef, CFStringRef, CFDictionaryRef, void *);

int _CTServerConnectionSetVibratorState(int *, void *, int, int, int, int, int);
*/
static void CTdyldCallBack(const struct mach_header* mh, intptr_t vmaddr_slide){
	Dl_info image_info;
	dladdr(mh, &image_info);//Will This Trigger Our Hook in DLFCN?
	const char *image_name = image_info.dli_fname;
	NSString* name=[NSString stringWithUTF8String:image_name];
	if([name containsString:@"CoreTelephony"]){
	%init(CoreTelephony);
	MSHookFunction(((void*)MSFindSymbol(NULL, "__CTServerConnectionCopyMobileEquipmentInfo")),(void*)new_CTServerConnectionCopyMobileEquipmentInfo, (void**)&old_CTServerConnectionCopyMobileEquipmentInfo);	
	MSHookFunction(((void*)MSFindSymbol(NULL, "__CTServerConnectionCellMonitorGetCellCount")),(void*)_CTServerConnectionCellMonitorGetCellCount, (void**)&old_CTServerConnectionCellMonitorGetCellCount);
	MSHookFunction(((void*)MSFindSymbol(NULL, "__CTServerConnectionCellMonitorGetCellInfo")),(void*)_CTServerConnectionCellMonitorGetCellInfo, (void**)&old_CTServerConnectionCellMonitorGetCellInfo);
	
	}
	[name release];

}


extern void init_CoreTelephony_hook(){
_dyld_register_func_for_add_image(&CTdyldCallBack);
}

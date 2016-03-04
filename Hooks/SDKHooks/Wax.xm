#import "../SharedDefine.pch"
/*void json_parseString(lua_State *L, const char *input);

void wax_startWithNil();

//setup lua, and load wax stdlib
void wax_start(char *initScript, lua_CFunction extensionFunctions, ...);

//start with wax server
void wax_startWithServer();

//setup lua
void wax_setup();
int wax_runLuaString(const char *script);

*/
void (*old_wax_xml_parseString)(void *L, const char *input);
int (*old_wax_runLuaFile)(const char *filePath);
int (*old_wax_runLuaByteCode)(NSData *data, NSString *name);
int (*old_wax_runLuaString)(const char *script);

void _wax_xml_parseString(void *L, const char *input){
		NSString* NSinput=[NSString stringWithUTF8String:input];
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"wax" andMethod:@"wax_xml_parseString"];
		[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"L"];
		[tracer addArgFromPlistObject:NSinput withKey:@"input"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		[NSinput release];
		old_wax_xml_parseString(L,input);

}
int _wax_runLuaFile(const char *filePath){
	NSString* path=[NSString stringWithUTF8String:filePath];
	NSData* data=[NSData dataWithContentsOfFile:path];
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"wax" andMethod:@"wax_runLuaFile"];
	[tracer addArgFromPlistObject:path withKey:@"Path"];
	[tracer addArgFromPlistObject:data withKey:@"Data"];
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	[data release];
	[path release];
	return old_wax_runLuaFile(filePath);
}
int _wax_runLuaByteCode(NSData *data, NSString *name){
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"wax" andMethod:@"wax_runLuaByteCode"];
		[tracer addArgFromPlistObject:data withKey:@"data"];
		[tracer addArgFromPlistObject:name withKey:@"name"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	return old_wax_runLuaByteCode(data,name);
}
int _wax_runLuaString(const char *script){
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"wax" andMethod:@"wax_runLuaString"];
		[tracer addArgFromPlistObject:[NSString stringWithUTF8String:script] withKey:@"script"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		return old_wax_runLuaString(script);
}
extern void init_Wax_hook() {
	MSHookFunction(((void*)MSFindSymbol(NULL, "_wax_xml_parseString")),(void*)_wax_xml_parseString, (void**)&old_wax_xml_parseString);
	MSHookFunction(((void*)MSFindSymbol(NULL, "_wax_runLuaFile")),(void*)_wax_runLuaFile, (void**)&old_wax_runLuaFile);
	MSHookFunction(((void*)MSFindSymbol(NULL, "_wax_runLuaByteCode")),(void*)_wax_runLuaByteCode, (void**)&old_wax_runLuaByteCode);
	MSHookFunction(((void*)MSFindSymbol(NULL, "_wax_runLuaString")),(void*)_wax_runLuaString, (void**)&old_wax_runLuaString);
}






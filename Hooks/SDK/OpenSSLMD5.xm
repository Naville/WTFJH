#import <substrate.h>
#import "../SharedDefine.pch"
# define MD5_LONG unsigned int

# define MD5_CBLOCK      64
# define MD5_LBLOCK      (MD5_CBLOCK/4)
# define MD5_DIGEST_LENGTH 16

typedef struct MD5state_st {
    MD5_LONG A, B, C, D;
    MD5_LONG Nl, Nh;
    MD5_LONG data[MD5_LBLOCK];
    unsigned int num;
} MD5_CTX;

int (*old_MD5_Update)(MD5_CTX *c, const void *data, size_t len);
int (*old_MD5_Final)(unsigned char *md, MD5_CTX *c);
int MD5_Update(MD5_CTX *c, const void *data, size_t len){
		NSData* InputData=[NSData dataWithBytes:data length:len];
		int origResult=old_MD5_Update(c,data,len);
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/MD5" andMethod:@"MD5_Update"];
		[tracer addArgFromPlistObject:InputData withKey:@"InputData"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		[InputData release];
		return origResult;

}
int MD5_Final(unsigned char *md, MD5_CTX *c){
	int origResult=old_MD5_Final(md,c);
	NSMutableString *Hash = [NSMutableString string];
	for (int i=0; i<MD5_DIGEST_LENGTH; i++){[Hash appendFormat:@"%02x", md[i]];}
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/MD5" andMethod:@"MD5_Final"];
	[tracer addArgFromPlistObject:Hash withKey:@"MD5Hash"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt: origResult]];
		 
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	[Hash release];
	return origResult;

}
extern void init_OpenSSLMD5_hook(){
MSHookFunction(((void*)MSFindSymbol(NULL, "_MD5_Update")),(void*)MD5_Update, (void**)&old_MD5_Update);
MSHookFunction(((void*)MSFindSymbol(NULL, "_MD5_Final")),(void*)MD5_Final, (void**)&old_MD5_Final);
}

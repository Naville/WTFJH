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
int MD5_Update(MD5_CTX *c, const void *data, size_t len){
		NSData* InputData=[NSData dataWithBytes:data length:len];
		int origResult=old_MD5_Update(c,data,len);
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/MD5_Update" andMethod:@"MD5_Update"];
		[tracer addArgFromPlistObject:InputData withKey:@"InputData"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		[InputData release];
		return origResult;

}
extern void init_OpenSSL_hook(){
MSHookFunction(((void*)MSFindSymbol(NULL, "MD5_Update")),(void*)MD5_Update, (void**)&old_MD5_Update);
}

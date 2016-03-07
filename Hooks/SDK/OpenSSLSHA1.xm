#import "../SharedDefine.pch"
# define SHA_LONG unsigned int

# define SHA_LBLOCK      16
# define SHA_CBLOCK      (SHA_LBLOCK*4)/* SHA treats input data as a
                                        * contiguous array of 32 bit wide
                                        * big-endian values. */
# define SHA_LAST_BLOCK  (SHA_CBLOCK-8)
# define SHA_DIGEST_LENGTH 20
#define SHA1_DIGEST_SIZE 20
typedef struct SHAstate_st {
    SHA_LONG h0, h1, h2, h3, h4;
    SHA_LONG Nl, Nh;
    SHA_LONG data[SHA_LBLOCK];
    unsigned int num;
} SHA_CTX;

int (*old_SHA1_Update)(SHA_CTX *c, const void *data, size_t len);
int (*old_SHA1_Final)(unsigned char *md, SHA_CTX *c);
int (*old_SHA1)(const unsigned char *d, size_t n, unsigned char *md);
int SHA1_Update(SHA_CTX *c, const void *data, size_t len){
		NSData* InputData=[NSData dataWithBytes:data length:len];
		int origResult=old_SHA1_Update(c,data,len);
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/SHA" andMethod:@"SHA1_Update"];
		[tracer addArgFromPlistObject:InputData withKey:@"InputData"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		[InputData release];
		return origResult;

}
int SHA1_Final(unsigned char *md, SHA_CTX *c){
	int origResult=old_SHA1_Final(md,c);
	NSMutableString *Hash = [NSMutableString string];
	for (int i=0; i<SHA1_DIGEST_SIZE; i++){[Hash appendFormat:@"%02x", md[i]];}
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/SHA" andMethod:@"SHA1_Final"];
	[tracer addArgFromPlistObject:Hash withKey:@"SHA1Hash"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt: origResult]];
		 
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	[Hash release];
	return origResult;

}
int SHA1(const unsigned char *d, size_t n, unsigned char *md){
	NSData* InputData=[NSData dataWithBytes:d length:n];
	int origResult=old_SHA1(d,n,md);
	NSMutableString *Hash = [NSMutableString string];
	for (int i=0; i<SHA1_DIGEST_SIZE; i++){[Hash appendFormat:@"%02x", md[i]];}
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/SHA" andMethod:@"SHA1"];
		[tracer addArgFromPlistObject:InputData withKey:@"InputData"];
		[tracer addArgFromPlistObject:Hash withKey:@"SHA1Hash"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		[InputData release];
		return origResult;
}

extern void init_OpenSSLSHA1_hook(){
MSHookFunction(((void*)MSFindSymbol(NULL, "_SHA1_Update")),(void*)SHA1_Update, (void**)&old_SHA1_Update);
MSHookFunction(((void*)MSFindSymbol(NULL, "_SHA1_Final")),(void*)SHA1_Final, (void**)&old_SHA1_Final);
MSHookFunction(((void*)MSFindSymbol(NULL, "_SHA1")),(void*)SHA1, (void**)&old_SHA1);

//void SHA1_Transform(SHA_CTX *c, const unsigned char *data);
}
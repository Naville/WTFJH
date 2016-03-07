#import "../SharedDefine.pch"
# define SHA_LONG unsigned int

# define SHA_LBLOCK      16
# define SHA_CBLOCK      (SHA_LBLOCK*4)/* SHA treats input data as a
                                        * contiguous array of 32 bit wide
                                        * big-endian values. */
# define SHA512_CBLOCK   (SHA_LBLOCK*8)
# define SHA_LAST_BLOCK  (SHA_CBLOCK-8)
# define SHA_DIGEST_LENGTH 20
# define SHA512_DIGEST_LENGTH    64
# if (defined(_WIN32) || defined(_WIN64)) && !defined(__MINGW32__)
#  define SHA_LONG64 unsigned __int64
#  define U64(C)     C##UI64
# elif defined(__arch64__)
#  define SHA_LONG64 unsigned long
#  define U64(C)     C##UL
# else
#  define SHA_LONG64 unsigned long long
#  define U64(C)     C##ULL
# endif
typedef struct SHA512state_st {
    SHA_LONG64 h[8];
    SHA_LONG64 Nl, Nh;
    union {
        SHA_LONG64 d[SHA_LBLOCK];
        unsigned char p[SHA512_CBLOCK];
    } u;
    unsigned int num, md_len;
} SHA512_CTX;
# define SHA512_CBLOCK   (SHA_LBLOCK*8)
int (*old_SHA512_Update)(SHA512_CTX *c, const void *data, size_t len);
int (*old_SHA512_Final)(unsigned char *md, SHA512_CTX *c);
int (*old_SHA512)(const unsigned char *d, size_t n, unsigned char *md);
int SHA512_Update(SHA512_CTX *c, const void *data, size_t len){
		NSData* InputData=[NSData dataWithBytes:data length:len];
		int origResult=old_SHA512_Update(c,data,len);
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/SHA512" andMethod:@"SHA512_Update"];
		[tracer addArgFromPlistObject:InputData withKey:@"InputData"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		[InputData release];
		return origResult;

}
int SHA512_Final(unsigned char *md, SHA512_CTX *c){
	int origResult=old_SHA512_Final(md,c);
	NSMutableString *Hash = [NSMutableString string];
	for (int i=0; i<SHA512_DIGEST_LENGTH; i++){[Hash appendFormat:@"%02x", md[i]];}
	CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/SHA" andMethod:@"SHA512_Final"];
	[tracer addArgFromPlistObject:Hash withKey:@"SHA512Hash"];
	[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt: origResult]];
		 
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	[Hash release];
	return origResult;

}
int SHA512(const unsigned char *d, size_t n, unsigned char *md){
	NSData* InputData=[NSData dataWithBytes:d length:n];
	int origResult=old_SHA512(d,n,md);
	NSMutableString *Hash = [NSMutableString string];
	for (int i=0; i<SHA512_DIGEST_LENGTH; i++){[Hash appendFormat:@"%02x", md[i]];}
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/SHA" andMethod:@"SHA512"];
		[tracer addArgFromPlistObject:InputData withKey:@"InputData"];
		[tracer addArgFromPlistObject:Hash withKey:@"SHA512Hash"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithInt: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		[InputData release];
		return origResult;
}


extern void init_OpenSSLSHA512_hook(){
MSHookFunction(((void*)MSFindSymbol(NULL, "_SHA512_Update")),(void*)SHA512_Update, (void**)&old_SHA512_Update);
MSHookFunction(((void*)MSFindSymbol(NULL, "_SHA512_Final")),(void*)SHA512_Final, (void**)&old_SHA512_Final);
MSHookFunction(((void*)MSFindSymbol(NULL, "_SHA512")),(void*)SHA512, (void**)&old_SHA512);
//void SHA512_Transform(SHA512_CTX *c, const unsigned char *data);
}
#import "../SharedDefine.pch"

# define BF_LONG unsigned int

# define BF_ROUNDS       16
# define BF_BLOCK        8
 NSArray* Methods=@[@"BF_DECRYPT",@"BF_ENCRYPT"];

typedef struct bf_key_st {
    BF_LONG P[BF_ROUNDS + 2];
    BF_LONG S[4 * 256];
} BF_KEY;
 static NSMutableDictionary* ConvertBF_Key(BF_KEY* Key){
	NSMutableArray* PBoxarray=[NSMutableArray array];
	NSMutableArray* SBoxarray=[NSMutableArray array];
	NSMutableDictionary* RetValue=[NSMutableDictionary dictionary];
	for (int i = 0; i < (BF_ROUNDS + 2); i++)
	{
		BF_LONG x=Key->P[i];
		[PBoxarray addObject:[NSNumber numberWithUnsignedInt:x]];
	}
	for (int j = 0; j < (4 * 256); j++)
	{
		BF_LONG x=Key->S[j];
		[SBoxarray addObject:[NSNumber numberWithUnsignedInt:x]];
	}
	[RetValue setObject:PBoxarray forKey:@"PBox"];
	[RetValue setObject:SBoxarray forKey:@"SBox"];
	[PBoxarray release];
	[SBoxarray release];
	return RetValue;
}
 void (*old_BF_set_key)( BF_KEY *key, int len,  unsigned char *data);
 void BF_set_key(BF_KEY *key, int len,  unsigned char *data){
		//NSMutableDictionary* dict=ConvertBF_Key(key);
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/BlowFish" andMethod:@"BF_set_key"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:data length:len] withKey:@"Key"];

		[traceStorage saveTracedCall: tracer];
		[tracer release];
		old_BF_set_key(key,len,data);

}
//void BF_decrypt(BF_LONG *data,  BF_KEY *key);
//BF_encrypt() and BF_decrypt() are the lowest level functions for Blowfish encryption. They encrypt/decrypt the first 64 bits of the vector pointed by data, using the key key. These functions should not be used unless you implement 'modes' of Blowfish. The alternative is to use BF_ecb_encrypt(). If you still want to use these functions, you should be aware that they take each 32-bit chunk in host-byte order, which is little-endian on little-endian platforms and big-endian on big-endian ones.
void (*old_BF_encrypt)(BF_LONG *data,BF_KEY *key);
void (*old_BF_decrypt)(BF_LONG *data,BF_KEY *key);
void BF_encrypt(BF_LONG *data,  BF_KEY *key){
		if([CallStackInspector wasDirectlyCalledByFunctionWithName:@"BF_"]){
			//We Don't Wanna Log OpenSSL Internal Calls
		}
		else{
			NSData* Inputdata=[NSData dataWithBytes:data length:2*sizeof(BF_LONG)];
			NSMutableDictionary* dict=ConvertBF_Key(key);
			CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/BlowFish" andMethod:@"BF_encrypt"];
			[tracer addArgFromPlistObject:dict withKey:@"P&SBox"];
			[tracer addArgFromPlistObject:Inputdata withKey:@"Data"];
			[traceStorage saveTracedCall: tracer];
			[tracer release];
			[Inputdata release];
			[dict release];
		}
		old_BF_encrypt(data,key);

}
void BF_decrypt(BF_LONG *data,  BF_KEY *key){
		if([CallStackInspector wasDirectlyCalledByFunctionWithName:@"BF_"]){
			//We Don't Wanna Log OpenSSL Internal Calls
		}
		else{
			NSData* Inputdata=[NSData dataWithBytes:data length:2*sizeof(BF_LONG)];
			NSMutableDictionary* dict=ConvertBF_Key(key);
			CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/BlowFish" andMethod:@"BF_decrypt"];
			[tracer addArgFromPlistObject:dict withKey:@"P&SBox"];
			[tracer addArgFromPlistObject:Inputdata withKey:@"Data"];
			[traceStorage saveTracedCall: tracer];
			[tracer release];
			[Inputdata release];
			[dict release];
		}
		old_BF_decrypt(data,key);

}
 void (*old_BF_ecb_encrypt)( unsigned char *in, unsigned char *out,
                     BF_KEY *key, int enc);
 void (*old_BF_cbc_encrypt)( unsigned char *in, unsigned char *out, long length,
                     BF_KEY *schedule, unsigned char *ivec, int enc);
 void (*old_BF_cfb64_encrypt)( unsigned char *in, unsigned char *out,
                      long length,  BF_KEY *schedule,
                      unsigned char *ivec, int *num, int enc);
 void (*old_BF_ofb64_encrypt)( unsigned char *in, unsigned char *out,
                      long length,  BF_KEY *schedule,
                      unsigned char *ivec, int *num);
 void BF_ecb_encrypt( unsigned char *in, unsigned char *out,
                     BF_KEY *key, int enc){
		old_BF_ecb_encrypt(in,out,key,enc);//Call Original
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/BlowFish" andMethod:@"BF_ecb_encrypt"];
		[tracer addArgFromPlistObject:ConvertBF_Key(key) withKey:@"P&SBox"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:in length:BF_BLOCK] withKey:@"InputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:out length:BF_BLOCK] withKey:@"OutputData"];
		[tracer addArgFromPlistObject:[Methods objectAtIndex:enc] withKey:@"CryptType"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];

}
 void BF_cbc_encrypt( unsigned char *in, unsigned char *out, long length,
                     BF_KEY *schedule, unsigned char *ivec, int enc){
		old_BF_cbc_encrypt(in,out,length,schedule,ivec,enc);//Call Original
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/BlowFish" andMethod:@"BF_cbc_encrypt"];
		[tracer addArgFromPlistObject:ConvertBF_Key(schedule) withKey:@"P&SBox"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:in length:length] withKey:@"InputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:out length:length] withKey:@"OutputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:ivec length:BF_BLOCK] withKey:@"IV"];
		[tracer addArgFromPlistObject:[Methods objectAtIndex:enc] withKey:@"CryptType"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];

}
 void BF_cfb64_encrypt( unsigned char *in, unsigned char *out,
                      long length,  BF_KEY *schedule,
                      unsigned char *ivec, int *num, int enc){
		old_BF_cfb64_encrypt(in,out,length,schedule,ivec,num,enc);//Call Original
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/BlowFish" andMethod:@"BF_cfb64_encrypt"];
		[tracer addArgFromPlistObject:ConvertBF_Key(schedule) withKey:@"P&SBox"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:in length:length] withKey:@"InputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:out length:length] withKey:@"OutputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:ivec length:BF_BLOCK] withKey:@"IV"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInt:*num] withKey:@"num"];
		[tracer addArgFromPlistObject:[Methods objectAtIndex:enc] withKey:@"CryptType"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];

}
 void BF_ofb64_encrypt( unsigned char *in, unsigned char *out,
                      long length,  BF_KEY *schedule,
                      unsigned char *ivec, int *num){
		old_BF_ofb64_encrypt(in,out,length,schedule,ivec,num);//Call Original
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/BlowFish" andMethod:@"BF_ofb64_encrypt"];
		[tracer addArgFromPlistObject:ConvertBF_Key(schedule) withKey:@"P&SBox"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:in length:length] withKey:@"InputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:out length:length] withKey:@"OutputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:ivec length:BF_BLOCK] withKey:@"IV"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInt:*num] withKey:@"num"];
		//[tracer addArgFromPlistObject:[Methods objectAtIndex:enc] withKey:@"CryptType"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];

}
extern void init_OpenSSLBlowFish_hook(){
MSHookFunction(((void*)MSFindSymbol(NULL, "_BF_set_key")),(void*)BF_set_key, (void**)&old_BF_set_key);
MSHookFunction(((void*)MSFindSymbol(NULL, "_BF_ecb_encrypt")),(void*)BF_ecb_encrypt, (void**)&old_BF_ecb_encrypt);
MSHookFunction(((void*)MSFindSymbol(NULL, "_BF_cbc_encrypt")),(void*)BF_cbc_encrypt, (void**)&old_BF_cbc_encrypt);
MSHookFunction(((void*)MSFindSymbol(NULL, "_BF_cfb64_encrypt")),(void*)BF_cfb64_encrypt, (void**)&old_BF_cfb64_encrypt);
MSHookFunction(((void*)MSFindSymbol(NULL, "_BF_ofb64_encrypt")),(void*)BF_ofb64_encrypt, (void**)&old_BF_ofb64_encrypt);
#ifdef PROTOTYPE
MSHookFunction(((void*)MSFindSymbol(NULL, "_BF_decrypt")),(void*)BF_decrypt, (void**)&old_BF_decrypt);
MSHookFunction(((void*)MSFindSymbol(NULL, "_BF_encrypt")),(void*)BF_encrypt, (void**)&old_BF_encrypt);
#endif 

}

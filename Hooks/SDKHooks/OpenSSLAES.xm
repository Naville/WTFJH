#import "../SharedDefine.pch"
#import "string.h"

# define AES_ENCRYPT     1
# define AES_DECRYPT     0
static NSArray* Methods=@[@"AES_DECRYPT",@"AES_ENCRYPT"];
/*
 * Because array size can't be a const in C, the following two are macros.
 * Both sizes are in bytes.
 */
# define AES_MAXNR 14
# define AES_BLOCK_SIZE 16
/* This should be a hidden type, but EVP requires that the size be known */
struct aes_key_st {
# ifdef AES_LONG
    unsigned long rd_key[4 * (AES_MAXNR + 1)];
# else
    unsigned int rd_key[4 * (AES_MAXNR + 1)];
# endif
    int rounds;
};
typedef struct aes_key_st AES_KEY;


int (*old_AES_set_encrypt_key)(const unsigned char *userKey, const int bits,
                        AES_KEY *key);
int (*old_AES_set_decrypt_key)(const unsigned char *userKey, const int bits,
                        AES_KEY *key);
void (*old_AES_ecb_encrypt)(const unsigned char *in, unsigned char *out,
                     const AES_KEY *key, const int enc);
void (*old_AES_cbc_encrypt)(const unsigned char *in, unsigned char *out,
                     size_t length, const AES_KEY *key,
                     unsigned char *ivec, const int enc);
void (*old_AES_cfb128_encrypt)(const unsigned char *in, unsigned char *out,
                        size_t length, const AES_KEY *key,
                        unsigned char *ivec, int *num, const int enc);
int AES_set_encrypt_key(const unsigned char *userKey, const int bits,AES_KEY *key){
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/AES" andMethod:@"AES_set_encrypt_key"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:userKey length:bits] withKey:@"Key"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		return old_AES_set_encrypt_key(userKey,bits,key);//Call Original


}
int AES_set_decrypt_key(const unsigned char *userKey, const int bits,AES_KEY *key){
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/AES" andMethod:@"AES_set_decrypt_key"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:userKey length:bits] withKey:@"Key"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		return old_AES_set_decrypt_key(userKey,bits,key);//Call Original


}
void AES_ecb_encrypt(const unsigned char *in, unsigned char *out,
                     const AES_KEY *key, const int enc){
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/AES" andMethod:@"AES_ecb_encrypt"];
		[tracer addArgFromPlistObject:[Methods objectAtIndex:enc] withKey:@"Method"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:in length:AES_BLOCK_SIZE] withKey:@"InputData"];
		old_AES_ecb_encrypt(in,out,key,enc);//Call Original
		[tracer addArgFromPlistObject:[NSData dataWithBytes:out length:AES_BLOCK_SIZE] withKey:@"OutputData"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];

}
void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
                     size_t length, const AES_KEY *key,
                     unsigned char *ivec, const int enc){
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/AES" andMethod:@"AES_cbc_encrypt"];
		[tracer addArgFromPlistObject:[Methods objectAtIndex:enc] withKey:@"Method"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:in length:AES_BLOCK_SIZE] withKey:@"InputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:ivec length:AES_BLOCK_SIZE] withKey:@"IV"];

		old_AES_cbc_encrypt(in,out,length,key,ivec,enc);//Call Original
		[tracer addArgFromPlistObject:[NSData dataWithBytes:out length:AES_BLOCK_SIZE] withKey:@"OutputData"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];


}
void AES_cfb128_encrypt(const unsigned char *in, unsigned char *out,
                        size_t length, const AES_KEY *key,
                        unsigned char *ivec, int *num, const int enc){
	old_AES_cfb128_encrypt(in,out,length,key,ivec,num,enc);//Call Original
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/AES" andMethod:@"AES_cfb128_encrypt"];
		[tracer addArgFromPlistObject:[Methods objectAtIndex:enc] withKey:@"Method"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:in length:AES_BLOCK_SIZE] withKey:@"InputData"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:ivec length:AES_BLOCK_SIZE] withKey:@"IV"];


		[tracer addArgFromPlistObject:[NSNumber numberWithInt:*num] withKey:@"num"];
		[tracer addArgFromPlistObject:[NSData dataWithBytes:out length:AES_BLOCK_SIZE] withKey:@"OutputData"];
		[traceStorage saveTracedCall: tracer];
		[tracer release];



}
extern void init_OpenSSLAES_hook() {
MSHookFunction(((void*)MSFindSymbol(NULL, "_AES_set_encrypt_key")),(void*)AES_set_encrypt_key, (void**)&old_AES_set_encrypt_key);
MSHookFunction(((void*)MSFindSymbol(NULL, "_AES_set_decrypt_key")),(void*)AES_set_decrypt_key, (void**)&old_AES_set_decrypt_key);
MSHookFunction(((void*)MSFindSymbol(NULL, "_AES_ecb_encrypt")),(void*)AES_ecb_encrypt, (void**)&old_AES_ecb_encrypt);
MSHookFunction(((void*)MSFindSymbol(NULL, "_AES_cbc_encrypt")),(void*)AES_cbc_encrypt, (void**)&old_AES_cbc_encrypt);
MSHookFunction(((void*)MSFindSymbol(NULL, "_AES_cfb128_encrypt")),(void*)AES_cfb128_encrypt, (void**)&old_AES_cfb128_encrypt);
#ifdef PROTOTYPE

#endif
}

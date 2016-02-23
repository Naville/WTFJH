#import "../SharedDefine.pch"
# define AES_ENCRYPT     1
# define AES_DECRYPT     0

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
int AES_set_encrypt_key(const unsigned char *userKey, const int bits,AES_KEY *key){
		NSData* Keydata=[NSData dataWithBytes:userKey length:bits];
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"OpenSSL/AES" andMethod:@"AES_set_encrypt_key"];
		[tracer addArgFromPlistObject:Keydata withKey:@"Key"];
		[Keydata release];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
		return old_AES_set_encrypt_key(userKey,bits,key);//Call Original


}
extern void init_OpenSSLAES_hook() {
MSHookFunction(((void*)MSFindSymbol(NULL, "_AES_set_encrypt_key")),(void*)AES_set_encrypt_key, (void**)&old_AES_set_encrypt_key);
}

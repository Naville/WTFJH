
#include <substrate.h>
#include <CommonCrypto/CommonKeyDerivation.h>

#import "../Utils/SQLiteStorage.h"
#import "../Utils/PlistObjectConverter.h"
#import "../Utils/CallStackInspector.h"
#import "../SharedDefine.pch"





static int (*original_CCKeyDerivationPBKDF)(
    CCPBKDFAlgorithm algorithm, 
    const char *password, 
    size_t passwordLen,
    const uint8_t *salt,
    size_t saltLen, 
    CCPseudoRandomAlgorithm prf, 
    uint rounds,
    uint8_t *derivedKey,
    size_t derivedKeyLen);



static int replaced_CCKeyDerivationPBKDF(
    CCPBKDFAlgorithm algorithm, 
    const char *password, 
    size_t passwordLen,
    const uint8_t *salt,
    size_t saltLen, 
    CCPseudoRandomAlgorithm prf, 
    uint rounds,
    uint8_t *derivedKey,
    size_t derivedKeyLen) {

    int origResult = original_CCKeyDerivationPBKDF(algorithm, password, passwordLen, salt, saltLen, prf, rounds, derivedKey, derivedKeyLen);
    // Only log what the application directly calls. For example we don't want to log internal SSL crypto calls
    if ([CallStackInspector wasDirectlyCalledByApp]) {

        CallTracer *tracer = [[CallTracer alloc] initWithClass:@"C" andMethod:@"CCKeyDerivationPBKDF"];
        [tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) algorithm] withKey:@"algorithm"];
        [tracer addArgFromPlistObject:[PlistObjectConverter convertCBuffer: password withLength: passwordLen] withKey:@"password"];
        [tracer addArgFromPlistObject:[PlistObjectConverter convertCBuffer: salt withLength: saltLen] withKey:@"salt"];
        [tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) prf] withKey:@"prf"];
        [tracer addArgFromPlistObject:[NSNumber numberWithUnsignedInt: (unsigned int) rounds] withKey:@"rounds"];
        [tracer addArgFromPlistObject:[PlistObjectConverter convertCBuffer: derivedKey withLength: derivedKeyLen] withKey:@"derivedKey"];
        [tracer addReturnValueFromPlistObject: [NSNumber numberWithUnsignedInt:origResult]];
        [traceStorage saveTracedCall: tracer];
        [tracer release];
    }
    return origResult;}


extern void init_CommonKeyDerivation_hook(){
     MSHookFunction((void *) CCKeyDerivationPBKDF, (void *)  replaced_CCKeyDerivationPBKDF, (void **) &original_CCKeyDerivationPBKDF);
}


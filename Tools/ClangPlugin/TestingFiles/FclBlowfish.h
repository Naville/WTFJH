//
//  FclBlowfish.h
//
//  Created by Can on 8/8/13.
//  Copyright (c) 2013 Can Tecim. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//      http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  

#import <Foundation/Foundation.h>

typedef enum FclBlowfishMode
{
    modeEBC,    // electronic-code-book
    modeCBC     // cipher-block-chaining
} FclBlowfishMode;

typedef enum FclBlowfishPadding
{
    paddingRFC,
    paddingZero
} FclBlowfishPadding;

@interface FclBlowfish : NSObject {
    FclBlowfishMode mode;
    FclBlowfishPadding padding;
    unsigned short int N, blockSize;
    
    @private
    SInt32 P[16 + 2];
    SInt32 S[4][256];
}

@property(nonatomic, retain) NSString *Key; // Maximum 448 Bits, will be encoded using ASCII
@property(nonatomic, retain) NSString *IV;  // 8 Byte ASCII

- (NSString *)encrypt:(NSString *)plain withMode:(FclBlowfishMode)pMode
          withPadding:(FclBlowfishPadding)pPadding;
- (NSString *)decrypt:(NSString *)crypted withMode:(FclBlowfishMode)pMode
          withPadding:(FclBlowfishPadding)pPadding;
- (void)prepare;
- (NSString *)pad:(NSString *)plain;
- (NSString *)removePad:(NSString *)plain;
- (void)encipher:(SInt32 *)xl xr:(SInt32 *)xr;
- (void)decipher:(SInt32 *)xl xr:(SInt32 *)xr;
- (SInt32)F:(SInt32)v;

@end

static inline void FclSwap(SInt32 *l, SInt32 *r) {
    *l ^= *r;
    *r ^= *l;
    *l ^= *r;
}
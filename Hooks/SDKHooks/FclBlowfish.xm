#import "../SharedDefine.pch"
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
NSString * const ModeNames[] = {
    [modeEBC] = @"modeEBC",
    [modeCBC] = @"modeCBC",
};
NSString * const PaddingNames[] = {
    [paddingRFC] = @"paddingRFC",
    [paddingZero] = @"paddingZero",
};
%group FclBlowfish
%hook FclBlowfish
- (NSString *)encrypt:(NSString *)plain withMode:(FclBlowfishMode)pMode
          withPadding:(FclBlowfishPadding)pPadding{
     id ret=%orig;
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"FclBlowfish" andMethod:@"encrypt"];
	[tracer addArgFromPlistObject:plain withKey:@"Plain"];
	[tracer addArgFromPlistObject:ModeNames[pMode] withKey:@"BFMode"];
	[tracer addArgFromPlistObject:PaddingNames[pPadding] withKey:@"PaddingMode"];
	[tracer addReturnValueFromPlistObject:ret];
		 
	[traceStorage saveTracedCall: tracer];
	[tracer release];
	return ret;
          }
- (NSString *)decrypt:(NSString *)crypted withMode:(FclBlowfishMode)pMode
          withPadding:(FclBlowfishPadding)pPadding{
     id ret=%orig;
    CallTracer *tracer = [[CallTracer alloc] initWithClass:@"FclBlowfish" andMethod:@"decrypt"];
	[tracer addArgFromPlistObject:crypted withKey:@"Crypted"];
	[tracer addArgFromPlistObject:ModeNames[pMode] withKey:@"BFMode"];
	[tracer addArgFromPlistObject:PaddingNames[pPadding] withKey:@"PaddingMode"];
	[tracer addReturnValueFromPlistObject:ret];
		 
	[traceStorage saveTracedCall: tracer];
	[tracer release];
		return ret;
          }
%end
%end
extern void init_FclBlowfish_hook(){
if(objc_getClass("FclBlowfish")!=NULL){
	%init(FclBlowfish);
	}
}

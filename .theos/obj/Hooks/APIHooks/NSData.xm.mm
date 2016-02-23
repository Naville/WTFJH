#line 1 "Hooks/APIHooks/NSData.xm"









#include <logos/logos.h>
#include <substrate.h>
@class NSData; 


#line 10 "Hooks/APIHooks/NSData.xm"
#import "../SharedDefine.pch"
static BOOL (*_logos_orig$NSData$NSData$writeToFile$atomically$)(NSData*, SEL, NSString *, BOOL); static BOOL _logos_method$NSData$NSData$writeToFile$atomically$(NSData*, SEL, NSString *, BOOL); static BOOL (*_logos_orig$NSData$NSData$writeToFile$options$error$)(NSData*, SEL, NSString *, NSDataWritingOptions, NSError **); static BOOL _logos_method$NSData$NSData$writeToFile$options$error$(NSData*, SEL, NSString *, NSDataWritingOptions, NSError **); static BOOL (*_logos_orig$NSData$NSData$writeToURL$atomically$)(NSData*, SEL, NSURL *, BOOL); static BOOL _logos_method$NSData$NSData$writeToURL$atomically$(NSData*, SEL, NSURL *, BOOL); static BOOL (*_logos_orig$NSData$NSData$writeToURL$options$error$)(NSData*, SEL, NSURL *, NSDataWritingOptions, NSError **); static BOOL _logos_method$NSData$NSData$writeToURL$options$error$(NSData*, SEL, NSURL *, NSDataWritingOptions, NSError **); static id (*_logos_meta_orig$NSData$NSData$dataWithContentsOfFile$)(Class, SEL, NSString *); static id _logos_meta_method$NSData$NSData$dataWithContentsOfFile$(Class, SEL, NSString *); static id (*_logos_meta_orig$NSData$NSData$dataWithContentsOfFile$options$error$)(Class, SEL, NSString *, NSDataReadingOptions, NSError **); static id _logos_meta_method$NSData$NSData$dataWithContentsOfFile$options$error$(Class, SEL, NSString *, NSDataReadingOptions, NSError **); static id (*_logos_meta_orig$NSData$NSData$dataWithContentsOfURL$)(Class, SEL, NSURL *); static id _logos_meta_method$NSData$NSData$dataWithContentsOfURL$(Class, SEL, NSURL *); static id (*_logos_meta_orig$NSData$NSData$dataWithContentsOfURL$options$error$)(Class, SEL, NSURL *, NSDataReadingOptions, NSError **); static id _logos_meta_method$NSData$NSData$dataWithContentsOfURL$options$error$(Class, SEL, NSURL *, NSDataReadingOptions, NSError **); static id (*_logos_orig$NSData$NSData$initWithContentsOfFile$)(NSData*, SEL, NSString *); static id _logos_method$NSData$NSData$initWithContentsOfFile$(NSData*, SEL, NSString *); static id (*_logos_orig$NSData$NSData$initWithContentsOfFile$options$error$)(NSData*, SEL, NSString *, NSDataReadingOptions, NSError **); static id _logos_method$NSData$NSData$initWithContentsOfFile$options$error$(NSData*, SEL, NSString *, NSDataReadingOptions, NSError **); static id (*_logos_orig$NSData$NSData$initWithContentsOfURL$)(NSData*, SEL, NSURL *); static id _logos_method$NSData$NSData$initWithContentsOfURL$(NSData*, SEL, NSURL *); static id (*_logos_orig$NSData$NSData$initWithContentsOfURL$options$error$)(NSData*, SEL, NSURL *, NSDataReadingOptions, NSError **); static id _logos_method$NSData$NSData$initWithContentsOfURL$options$error$(NSData*, SEL, NSURL *, NSDataReadingOptions, NSError **); 


static BOOL _logos_method$NSData$NSData$writeToFile$atomically$(NSData* self, SEL _cmd, NSString * path, BOOL flag) {
	BOOL origResult = _logos_orig$NSData$NSData$writeToFile$atomically$(self, _cmd, path, flag);
	
    if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"writeToFile:atomically:"];
		[tracer addArgFromPlistObject:path withKey:@"path"];
		[tracer addArgFromPlistObject:[NSNumber numberWithBool: flag] withKey:@"flag"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool: origResult]];
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static BOOL _logos_method$NSData$NSData$writeToFile$options$error$(NSData* self, SEL _cmd, NSString * path, NSDataWritingOptions mask, NSError ** errorPtr) {
	BOOL origResult = _logos_orig$NSData$NSData$writeToFile$options$error$(self, _cmd, path, mask, errorPtr);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"writeToFile:options:error:"];
		[tracer addArgFromPlistObject:path withKey:@"path"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInteger: mask] withKey:@"mask"];
		
		[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"errorPtr"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static BOOL _logos_method$NSData$NSData$writeToURL$atomically$(NSData* self, SEL _cmd, NSURL * aURL, BOOL flag) {
	BOOL origResult = _logos_orig$NSData$NSData$writeToURL$atomically$(self, _cmd, aURL, flag);
    if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"writeToURL:atomically:"];
		[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: aURL] withKey:@"aURL"];
		[tracer addArgFromPlistObject:[NSNumber numberWithBool: flag] withKey:@"flag"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static BOOL _logos_method$NSData$NSData$writeToURL$options$error$(NSData* self, SEL _cmd, NSURL * aURL, NSDataWritingOptions mask, NSError ** errorPtr) {
	BOOL origResult = _logos_orig$NSData$NSData$writeToURL$options$error$(self, _cmd, aURL, mask, errorPtr);
    if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"writeToURL:options:error:"];
		[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: aURL] withKey:@"aURL"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInteger:mask] withKey:@"mask"];
		[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"errorPtr"];
		[tracer addReturnValueFromPlistObject:[NSNumber numberWithBool: origResult]];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static id _logos_meta_method$NSData$NSData$dataWithContentsOfFile$(Class self, SEL _cmd, NSString * path) {
	id origResult = _logos_meta_orig$NSData$NSData$dataWithContentsOfFile$(self, _cmd, path);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"dataWithContentsOfFile:"];
		[tracer addArgFromPlistObject:path withKey:@"path"];
		
		[tracer addReturnValueFromPlistObject: origResult];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static id _logos_meta_method$NSData$NSData$dataWithContentsOfFile$options$error$(Class self, SEL _cmd, NSString * path, NSDataReadingOptions mask, NSError ** errorPtr) {
	id origResult = _logos_meta_orig$NSData$NSData$dataWithContentsOfFile$options$error$(self, _cmd, path, mask, errorPtr);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"dataWithContentsOfFile:options:error:"];
		[tracer addArgFromPlistObject:path withKey:@"path"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInteger:mask] withKey:@"mask"];
		[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"errorPtr"];
		[tracer addReturnValueFromPlistObject: origResult];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static id _logos_meta_method$NSData$NSData$dataWithContentsOfURL$(Class self, SEL _cmd, NSURL * aURL) {
	id origResult = _logos_meta_orig$NSData$NSData$dataWithContentsOfURL$(self, _cmd, aURL);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"dataWithContentsOfURL:"];
		[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: aURL] withKey:@"aURL"];
		[tracer addReturnValueFromPlistObject: origResult];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static id _logos_meta_method$NSData$NSData$dataWithContentsOfURL$options$error$(Class self, SEL _cmd, NSURL * aURL, NSDataReadingOptions mask, NSError ** errorPtr) {
	id origResult = _logos_meta_orig$NSData$NSData$dataWithContentsOfURL$options$error$(self, _cmd, aURL, mask, errorPtr);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"dataWithContentsOfURL:options:error:"];
		[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: aURL] withKey:@"aURL"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInteger:mask] withKey:@"mask"];
		[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"errorPtr"];
		[tracer addReturnValueFromPlistObject: origResult];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static id _logos_method$NSData$NSData$initWithContentsOfFile$(NSData* self, SEL _cmd, NSString * path) {
	id origResult = _logos_orig$NSData$NSData$initWithContentsOfFile$(self, _cmd, path);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"initWithContentsOfFile:"];
		[tracer addArgFromPlistObject:path withKey:@"path"];
		[tracer addReturnValueFromPlistObject: origResult];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static id _logos_method$NSData$NSData$initWithContentsOfFile$options$error$(NSData* self, SEL _cmd, NSString * path, NSDataReadingOptions mask, NSError ** errorPtr) {
	id origResult = _logos_orig$NSData$NSData$initWithContentsOfFile$options$error$(self, _cmd, path, mask, errorPtr);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"initWithContentsOfFile:options:error:"];
		[tracer addArgFromPlistObject:path withKey:@"path"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInteger:mask] withKey:@"mask"];
		[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"errorPtr"];
		[tracer addReturnValueFromPlistObject: origResult];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static id _logos_method$NSData$NSData$initWithContentsOfURL$(NSData* self, SEL _cmd, NSURL * aURL) {
	id origResult = _logos_orig$NSData$NSData$initWithContentsOfURL$(self, _cmd, aURL);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"initWithContentsOfURL:"];
		[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: aURL] withKey:@"aURL"];
		[tracer addReturnValueFromPlistObject: origResult];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}

static id _logos_method$NSData$NSData$initWithContentsOfURL$options$error$(NSData* self, SEL _cmd, NSURL * aURL, NSDataReadingOptions mask, NSError ** errorPtr) {
	id origResult = _logos_orig$NSData$NSData$initWithContentsOfURL$options$error$(self, _cmd, aURL, mask, errorPtr);
	if ([CallStackInspector wasDirectlyCalledByApp]) {
		CallTracer *tracer = [[CallTracer alloc] initWithClass:@"NSData" andMethod:@"initWithContentsOfURL:options:error:"];
		[tracer addArgFromPlistObject:[PlistObjectConverter convertURL: aURL] withKey:@"aURL"];
		[tracer addArgFromPlistObject:[NSNumber numberWithInteger:mask] withKey:@"mask"];
		[tracer addArgFromPlistObject:objectTypeNotSupported withKey:@"errorPtr"];
		[tracer addReturnValueFromPlistObject: origResult];
		 
		[traceStorage saveTracedCall: tracer];
		[tracer release];
	}
	return origResult;
}




extern void init_NSData_hook(){
{Class _logos_class$NSData$NSData = objc_getClass("NSData"); Class _logos_metaclass$NSData$NSData = object_getClass(_logos_class$NSData$NSData); MSHookMessageEx(_logos_class$NSData$NSData, @selector(writeToFile:atomically:), (IMP)&_logos_method$NSData$NSData$writeToFile$atomically$, (IMP*)&_logos_orig$NSData$NSData$writeToFile$atomically$);MSHookMessageEx(_logos_class$NSData$NSData, @selector(writeToFile:options:error:), (IMP)&_logos_method$NSData$NSData$writeToFile$options$error$, (IMP*)&_logos_orig$NSData$NSData$writeToFile$options$error$);MSHookMessageEx(_logos_class$NSData$NSData, @selector(writeToURL:atomically:), (IMP)&_logos_method$NSData$NSData$writeToURL$atomically$, (IMP*)&_logos_orig$NSData$NSData$writeToURL$atomically$);MSHookMessageEx(_logos_class$NSData$NSData, @selector(writeToURL:options:error:), (IMP)&_logos_method$NSData$NSData$writeToURL$options$error$, (IMP*)&_logos_orig$NSData$NSData$writeToURL$options$error$);MSHookMessageEx(_logos_metaclass$NSData$NSData, @selector(dataWithContentsOfFile:), (IMP)&_logos_meta_method$NSData$NSData$dataWithContentsOfFile$, (IMP*)&_logos_meta_orig$NSData$NSData$dataWithContentsOfFile$);MSHookMessageEx(_logos_metaclass$NSData$NSData, @selector(dataWithContentsOfFile:options:error:), (IMP)&_logos_meta_method$NSData$NSData$dataWithContentsOfFile$options$error$, (IMP*)&_logos_meta_orig$NSData$NSData$dataWithContentsOfFile$options$error$);MSHookMessageEx(_logos_metaclass$NSData$NSData, @selector(dataWithContentsOfURL:), (IMP)&_logos_meta_method$NSData$NSData$dataWithContentsOfURL$, (IMP*)&_logos_meta_orig$NSData$NSData$dataWithContentsOfURL$);MSHookMessageEx(_logos_metaclass$NSData$NSData, @selector(dataWithContentsOfURL:options:error:), (IMP)&_logos_meta_method$NSData$NSData$dataWithContentsOfURL$options$error$, (IMP*)&_logos_meta_orig$NSData$NSData$dataWithContentsOfURL$options$error$);MSHookMessageEx(_logos_class$NSData$NSData, @selector(initWithContentsOfFile:), (IMP)&_logos_method$NSData$NSData$initWithContentsOfFile$, (IMP*)&_logos_orig$NSData$NSData$initWithContentsOfFile$);MSHookMessageEx(_logos_class$NSData$NSData, @selector(initWithContentsOfFile:options:error:), (IMP)&_logos_method$NSData$NSData$initWithContentsOfFile$options$error$, (IMP*)&_logos_orig$NSData$NSData$initWithContentsOfFile$options$error$);MSHookMessageEx(_logos_class$NSData$NSData, @selector(initWithContentsOfURL:), (IMP)&_logos_method$NSData$NSData$initWithContentsOfURL$, (IMP*)&_logos_orig$NSData$NSData$initWithContentsOfURL$);MSHookMessageEx(_logos_class$NSData$NSData, @selector(initWithContentsOfURL:options:error:), (IMP)&_logos_method$NSData$NSData$initWithContentsOfURL$options$error$, (IMP*)&_logos_orig$NSData$NSData$initWithContentsOfURL$options$error$);}
}




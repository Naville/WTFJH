#import "../Global.h"
%group NSData
%hook NSData

- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)flag {
	BOOL origResult = %orig(path, flag);
	// NSData methods are called a lot by other iOS APIs and we don't want to log that so we use the CallStackInspector
    if (WTShouldLog) {
		WTInit(@"NSData",@"writeToFile:atomically:");
		WTAdd(path,@"path");
		WTAdd([NSNumber numberWithBool: flag],@"flag");
		WTReturn([NSNumber numberWithBool: origResult]);
		WTSave;
		WTRelease;
	}
	return origResult;
}

- (BOOL)writeToFile:(NSString *)path options:(NSDataWritingOptions)mask error:(NSError **)errorPtr {
	BOOL origResult = %orig(path, mask, errorPtr);
	if (WTShouldLog) {
		WTInit(@"NSData",@"writeToFile:options:error:");
		WTAdd(path,@"path");
		WTAdd([NSNumber numberWithInteger: mask],@"mask");
		// For now let's just store the pointer value of the errorPtr parameter
		WTAdd(objectTypeNotSupported,@"errorPtr");
		WTReturn([NSNumber numberWithBool: origResult]);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

- (BOOL)writeToURL:(NSURL *)aURL atomically:(BOOL)flag {
	BOOL origResult = %orig(aURL, flag);
    if (WTShouldLog) {
		WTInit(@"NSData",@"writeToURL:atomically:");
		WTAdd([PlistObjectConverter convertURL: aURL],@"aURL");
		WTAdd([NSNumber numberWithBool: flag],@"flag");
		WTReturn([NSNumber numberWithBool: origResult]);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

- (BOOL)writeToURL:(NSURL *)aURL options:(NSDataWritingOptions)mask error:(NSError **)errorPtr {
	BOOL origResult = %orig(aURL, mask, errorPtr);
    if (WTShouldLog) {
		WTInit(@"NSData",@"writeToURL:options:error:");
		WTAdd([PlistObjectConverter convertURL: aURL],@"aURL");
		WTAdd([NSNumber numberWithInteger:mask],@"mask");
		WTAdd(objectTypeNotSupported,@"errorPtr");
		WTReturn([NSNumber numberWithBool: origResult]);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

+ (id)dataWithContentsOfFile:(NSString *)path {
	id origResult = %orig(path);
	if (WTShouldLog) {
		WTInit(@"NSData",@"dataWithContentsOfFile:");
		WTAdd(path,@"path");
		// origResult should be NSData* ?
		WTReturn( origResult);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

+ (id)dataWithContentsOfFile:(NSString *)path options:(NSDataReadingOptions)mask error:(NSError **)errorPtr {
	id origResult = %orig(path, mask, errorPtr);
	if (WTShouldLog) {
		WTInit(@"NSData",@"dataWithContentsOfFile:options:error:");
		WTAdd(path,@"path");
		WTAdd([NSNumber numberWithInteger:mask],@"mask");
		WTAdd(objectTypeNotSupported,@"errorPtr");
		WTReturn( origResult);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

+ (id)dataWithContentsOfURL:(NSURL *)aURL {
	id origResult = %orig(aURL);
	if (WTShouldLog) {
		WTInit(@"NSData",@"dataWithContentsOfURL:");
		WTAdd([PlistObjectConverter convertURL: aURL],@"aURL");
		WTReturn( origResult);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

+ (id)dataWithContentsOfURL:(NSURL *)aURL options:(NSDataReadingOptions)mask error:(NSError **)errorPtr {
	id origResult = %orig(aURL, mask, errorPtr);
	if (WTShouldLog) {
		WTInit(@"NSData",@"dataWithContentsOfURL:options:error:");
		WTAdd([PlistObjectConverter convertURL: aURL],@"aURL");
		WTAdd([NSNumber numberWithInteger:mask],@"mask");
		WTAdd(objectTypeNotSupported,@"errorPtr");
		WTReturn( origResult);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

- (id)initWithContentsOfFile:(NSString *)path {
	id origResult = %orig(path);
	if (WTShouldLog) {
		WTInit(@"NSData",@"initWithContentsOfFile:");
		WTAdd(path,@"path");
		WTReturn( origResult);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

- (id)initWithContentsOfFile:(NSString *)path options:(NSDataReadingOptions)mask error:(NSError **)errorPtr {
	NSLog(@"UIEWHKWEHRKLEWR");
	id origResult = %orig;
	if (WTShouldLog) {
		WTInit(@"NSData",@"initWithContentsOfFile:options:error:");
		WTAdd(path,@"path");
		WTAdd([NSNumber numberWithInteger:mask],@"mask");
		WTAdd(objectTypeNotSupported,@"errorPtr");
		WTReturn( origResult);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

- (id)initWithContentsOfURL:(NSURL *)aURL {
	id origResult = %orig(aURL);
	if (WTShouldLog) {
		WTInit(@"NSData",@"initWithContentsOfURL:");
		WTAdd([PlistObjectConverter convertURL: aURL],@"aURL");
		WTReturn( origResult);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}

- (id)initWithContentsOfURL:(NSURL *)aURL options:(NSDataReadingOptions)mask error:(NSError **)errorPtr {
	id origResult = %orig(aURL, mask, errorPtr);
	if (WTShouldLog) {
		WTInit(@"NSData",@"initWithContentsOfURL:options:error:");
		WTAdd([PlistObjectConverter convertURL: aURL],@"aURL");
		WTAdd([NSNumber numberWithInteger:mask],@"mask");
		WTAdd(objectTypeNotSupported,@"errorPtr");
		WTReturn( origResult);
		 
		WTSave;
		WTRelease;
	}
	return origResult;
}


%end
%end
extern void init_NSData_hook(){
	%init(NSData);
}


/* vim: set filetype=objc : */

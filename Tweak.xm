#import "./Hooks/SharedDefine.pch" 
// Utility function to parse the preference file
BOOL getBoolFromPreferences(NSString *preferenceValue) {
    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath];
    id value = [preferences objectForKey:preferenceValue];
    if (value == nil) {
        return YES; // default to YES
    }
    [preferences release];
    return [value boolValue];
}



// Log all custom URL schemes registered
// TODO: should we refactor this out of the main Tweak?
static void traceURISchemes() {
    NSArray *url_schemes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for (id schemeBundle in url_schemes) {
        NSString *name = [schemeBundle objectForKey:@"CFBundleURLName"];
        NSNumber *isPrivate = [schemeBundle objectForKey:@"CFBundleURLIsPrivate"];
        for (id scheme in [schemeBundle objectForKey:@"CFBundleURLSchemes"]) {
        CallTracer *tracer = [[CallTracer alloc] initWithClass:@"CFBundleURLTypes" andMethod:@"CFBundleURLSchemes"];
        [tracer addArgFromPlistObject:name withKey:@"CFBundleURLName"];
        [tracer addArgFromPlistObject:isPrivate withKey:@"CFBundleURLIsPrivate"];
        [tracer addArgFromPlistObject:scheme withKey:@"CFBundleURLScheme"];
        [traceStorage saveTracedCall:tracer];
        [tracer release];
        }
    }
}

%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    // Only hook Apps the user has selected in Introspy's settings panel
    NSString *appId = [[NSBundle mainBundle] bundleIdentifier];
    // Load Introspy preferences
    id shouldHook = [[[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath] objectForKey:appId];
    if ( (shouldHook == nil) || (! [shouldHook boolValue]) ) {
        NSLog(@"Introspy - Profiling disabled for %@", appId);
        [pool drain];
	    return;
    }
    if (getBoolFromPreferences(@"URLSchemesHooks")) {
            traceURISchemes();
     }
	// Initialize DB storage
    NSLog(@"Introspy - Profiling enabled for %@", appId);
    BOOL shouldLog = getBoolFromPreferences(@"LogToTheConsole");
    [[SQLiteStorage sharedManager] initWithDefaultDBFilePathAndLogToConsole: shouldLog];
	if (traceStorage != nil) {
        extern void GlobalInit();
        GlobalInit();
	}
	else {
		NSLog(@"Introspy - DB Initialization error; disabling hooks.");
	}

    [pool drain];
}
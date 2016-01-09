#import "./Hooks/SharedDefine.pch"
SQLiteStorage *traceStorage;
static NSString *preferenceFilePath = @"/private/var/mobile/Library/Preferences/naville.wtfjh.plist";    
// Utility function to parse the preference file
static BOOL getBoolFromPreferences(NSMutableDictionary *preferences, NSString *preferenceValue) {
    id value = [preferences objectForKey:preferenceValue];
    if (value == nil) {
        return YES; // default to YES
    }
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
    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath];
    id shouldHook = [preferences objectForKey:appId];
    if ( (shouldHook == nil) || (! [shouldHook boolValue]) ) {
        NSLog(@"Introspy - Profiling disabled for %@", appId);
    	[preferences release];
        [pool drain];
	    return;
    }
    if (getBoolFromPreferences(preferences, @"URLSchemesHooks")) {
            traceURISchemes();
     }
	// Initialize DB storage
    NSLog(@"Introspy - Profiling enabled for %@", appId);
    BOOL shouldLog = getBoolFromPreferences(preferences, @"LogToTheConsole");
	traceStorage = [[SQLiteStorage sharedManager] initWithDefaultDBFilePathAndLogToConsole: shouldLog];
	if (traceStorage != nil) {
	}
	else {
		NSLog(@"Introspy - DB Initialization error; disabling hooks.");
	}

    [preferences release];
    [pool drain];
}
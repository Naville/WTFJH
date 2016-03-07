#define PrefListPath @"/var/mobile/Preferences/naville.DeviceIDFake.plist"
static BOOL getBoolFromPreferences(NSString *preferenceValue) {
    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:PrefListPath];
    if(preferences==nil){
    	preferences=[NSMutableDictionary dictionary];
    	[preferences setObject:[NSNumber numberWithBool:YES] forKey:preferenceValue];
    	[preferences writeToFile:PrefListPath atomically:YES];
    	return YES;

    }
    else{
    id value = [preferences objectForKey:preferenceValue];
    if (value == nil) {
        return NO; // default to YES
    }
    [preferences release];
    BOOL retVal=[value boolValue];
    [value release];
    return retVal;
	}
}
%group ASIdentifierManager
%hook ASIdentifierManager
-(NSUUID*)advertisingIdentifier{
	return [NSUUID UUID];
}
-(BOOL)isAdvertisingTrackingEnabled{
	return NO;
}
%end
%end

%ctor{
	if (getBoolFromPreferences(@"ASIdentifierManager")==YES){
		%init(ASIdentifierManager);
	}


}
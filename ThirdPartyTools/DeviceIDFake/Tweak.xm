#define RandomNumber 1000
static NSString* RandomString(int size){
NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
NSMutableString *s = [NSMutableString stringWithCapacity:size];
for (NSUInteger i = 0; i < size; i++) {
    u_int32_t r = arc4random() % [alphabet length];
    unichar c = [alphabet characterAtIndex:r];
    [s appendFormat:@"%C", c];
}
return s;
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
 static CFTypeRef (*old_MGCopyAnswer)(CFStringRef property);
 static CFTypeRef MGCopyAnswer(CFStringRef property){
    CFTypeRef X=old_MGCopyAnswer(property);
    if (CFGetTypeID(X) == CFStringGetTypeID()) {
        NSString* Y=RandomString([(NSString *)X length]);
        CFRelease(X);
        return Y;
    }
    else if(CFGetTypeID(X) == CFNumberGetTypeID()){
        NSNumber* newNumber=@([(NSNumber*)X floatValue] + [[NSNumber numberWithInt: arc4random() % RandomNumber] floatValue]);
        CFRelease(X);
        return newNumber;

    }
    else{
        return X;

    }
}



%ctor{
	%init(ASIdentifierManager);
    MSHookFunction(((void*)MSFindSymbol(NULL, "_MGCopyAnswer")),(void*)MGCopyAnswer, (void**)&old_MGCopyAnswer);

}
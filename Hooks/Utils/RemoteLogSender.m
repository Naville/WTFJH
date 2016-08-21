//
//  RemoteLogSender.m
//  OSXPlayground
//
//  Created by Zhang Naville on 16/7/16.
//  Copyright © 2016年 navillezhang. All rights reserved.
//

#import "RemoteLogSender.h"
#import <Foundation/NSNetServices.h>
static id getValueFromPreferences(NSString *preferenceValue) {
    NSMutableDictionary *preferences = [[[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath] autorelease];
    return [preferences objectForKey:preferenceValue];

}
@implementation RemoteLogSender{
    NSString* DatabaseName;
    NSOperationQueue* opq;
    NSURL* LogServerURL;
    NSMutableURLRequest* request;
}
+(instancetype)sharedInstance{
    static RemoteLogSender *sharedUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtils = [[RemoteLogSender alloc] init];
    });
    return sharedUtils;
}
-(instancetype)init{
    self=[super init];
    self->DatabaseName=[NSString stringWithFormat:@"%@-%@.db",[NSBundle mainBundle].bundleIdentifier,[NSDate date]];
    self->opq=[[NSOperationQueue alloc] init];
    self->LogServerURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8000",getValueFromPreferences(@"LogServerIP")]];
    self->request = [[NSMutableURLRequest alloc] initWithURL:self->LogServerURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    return self;
}
//-(void)asyncCommand:(NSString*)Command{
-(void)sendCommand:(NSString*)Command{   
    
    [self->request setHTTPMethod:@"POST"];
    [self->request setValue:@"CREATE TABLE IF NOT EXISTS tracedCalls (className TEXT, methodName TEXT, argumentsAndReturnValueDict TEXT,CALLSTACK TEXT)" forHTTPHeaderField:@"SQL-Command"];
    [self->request setValue:self->DatabaseName forHTTPHeaderField:@"DatabaseName"];
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [self->request setValue:Command forHTTPHeaderField:@"SQL-Command"];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}
/*-(void)sendCommand:(NSString*)Command{
    [self->opq addOperationWithBlock:^{
        [self asyncCommand:Command];
    }];

}*/
@end

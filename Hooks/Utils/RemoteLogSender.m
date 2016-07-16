//
//  RemoteLogSender.m
//  OSXPlayground
//
//  Created by Zhang Naville on 16/7/16.
//  Copyright © 2016年 navillezhang. All rights reserved.
//

#import "RemoteLogSender.h"
#import <Foundation/NSNetServices.h>
@implementation RemoteLogSender{
    NSString* DatabaseName;
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
    
    
    return self;
}
-(void)sendCommand:(NSString*)Command{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@.local:8000",WTFJHHostName]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"CREATE TABLE IF NOT EXISTS tracedCalls (className TEXT, methodName TEXT, argumentsAndReturnValueDict TEXT)" forHTTPHeaderField:@"SQL-Command"];
    [request setValue:self->DatabaseName forHTTPHeaderField:@"DatabaseName"];
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [request setValue:Command forHTTPHeaderField:@"SQL-Command"];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
}
@end

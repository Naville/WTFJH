//
//  RemoteLogSender.h
//  OSXPlayground
//
//  Created by Zhang Naville on 16/7/16.
//  Copyright © 2016年 navillezhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteLogSender : NSObject
-(void)sendCommand:(NSString*)Command;
+(RemoteLogSender*)sharedInstance;
@end

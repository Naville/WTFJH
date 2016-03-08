//
//  RuntimeUtils.h
//  classRTDumper
//
//  Created by Zhang Naville on 24/12/2015.
//
//

#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"

@interface RuntimeUtils : NSObject
+(NSData*)dataForSegmentName:(NSString*)Segname SectName:(NSString*)SectName;
+(NSMutableArray*)getProtocalList;
+(NSMutableArray*)getCategoryList;
@end

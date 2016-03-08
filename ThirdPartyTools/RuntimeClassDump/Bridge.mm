//
//  Bridge.m
//  
//
//  Created by Zhang Naville on 25/12/2015.
//
//

#import <Foundation/Foundation.h>
#import "RuntimeUtils.h"
#import "objcStructs.mm"
NSArray* BridgedmethodList(struct method_list_t* List){
    NSMutableArray* ReturnArray=[NSMutableArray array];
    method_list_t::method_iterator start = List->begin();
    method_list_t::method_iterator end   = List->end();
    for (;start != end; start++) {
        NSString *Method = NSStringFromSelector(start->name);
        NSString* Types=[NSString stringWithUTF8String:start->types];
        NSDictionary* Dict=[NSDictionary dictionaryWithObjectsAndKeys:Types,Method,nil];
        [ReturnArray addObject:Dict];
    }
    return ReturnArray;
}
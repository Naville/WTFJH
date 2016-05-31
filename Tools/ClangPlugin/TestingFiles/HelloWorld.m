#import <Foundation/Foundation.h>
static NSString* Test(){

	return @"SADASDASD";
}
int main (int argc, const char * argv[])
{
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        NSLog (Test());
        [pool drain];
        return 0;
}


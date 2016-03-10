#ifdef PROTOTYPE
#import "WebShell.h"
@implementation WebShell : NSObject
-(instancetype)init{
	self=[super init];
	self->fatherPTY = open("/dev/ptmx", O_RDWR | O_NOCTTY);
	if(self->fatherPTY==-1){
		NSLog(@"/dev/ptmx Handle Returned Error");
		return nil;
	}
	grantpt(self->fatherPTY);
	unlockpt(self->fatherPTY);



	return self;
}
-(void)release{
	close(self->subprocessPTY);
	close(self->fatherPTY);
	[super release];


}
-(void)startChild{
	NSString* address=[[NSString stringWithFormat:@"127.0.0.1:%i",CyPort] autorelease];
	//Viva La Objective-C

 	const char *arg1[] = { "/usr/bin/cycript", "-r", address.UTF8String, NULL };
    const char *envp[] = { "TERM=xterm-256color", NULL };
    execve(arg1[0],arg1,envp);

}


@end

#endif
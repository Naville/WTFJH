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
	self->SSHPID = fork();
	if(self->SSHPID==0){
		//Success
		self->subprocessPTY=open(ptsname(self->fatherPTY),O_RDWR | O_NOCTTY);
		if(self->subprocessPTY==-1){
			//Error
			return nil;
		}
		setsid();
        ioctl(self->subprocessPTY, TIOCSCTTY, 0);
        //Redirect Subprocess's STDIN/OUT/ERR To The SubPTY
        dup2(self->subprocessPTY, STDIN_FILENO);
        dup2(self->subprocessPTY, STDOUT_FILENO);
        dup2(self->subprocessPTY, STDERR_FILENO);
        close(self->fatherPTY);

	}


	return self;
}
-(void)ExecuteCommand:(NSString*)command{
	char* charCommand=command.UTF8String;
	write(self->fatherPTY, &charCommand, (size_t)[command length]);


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
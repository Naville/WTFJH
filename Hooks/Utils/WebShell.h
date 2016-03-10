#ifdef PROTOTYPE
#import <Foundation/Foundation.h>
#import <spawn.h>
#import <termios.h>
#import <unistd.h>
#import <sys/ioctl.h>
@interface WebShell{
int subprocessPTY;
int fatherPTY;
pid_t processPID;
pid_t SSHPID;
}
-(instancetype)init;
@end


#endif
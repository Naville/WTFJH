#import "../SharedDefine.pch"
#import <sys/socket.h>

/*
int	bind(int, const struct sockaddr *, socklen_t) ;
int	connect(int, const struct sockaddr *, socklen_t) __DARWIN_ALIAS_C( connect);
int	getpeername(int, struct sockaddr * __restrict, socklen_t * __restrict)
		__DARWIN_ALIAS(getpeername);
int	getsockname(int, struct sockaddr * __restrict, socklen_t * __restrict)
		__DARWIN_ALIAS(getsockname);
int	getsockopt(int, int, int, void * __restrict, socklen_t * __restrict);
int	listen(int, int) __DARWIN_ALIAS(listen);
ssize_t	recv(int, void *, size_t, int) __DARWIN_ALIAS_C(recv);
ssize_t	recvfrom(int, void *, size_t, int, struct sockaddr * __restrict,
		socklen_t * __restrict) __DARWIN_ALIAS_C(recvfrom);
ssize_t	recvmsg(int, struct msghdr *, int) __DARWIN_ALIAS_C(recvmsg);
ssize_t	send(int, const void *, size_t, int) __DARWIN_ALIAS_C(send);
ssize_t	sendmsg(int, const struct msghdr *, int) __DARWIN_ALIAS_C(sendmsg);
ssize_t	sendto(int, const void *, size_t,
		int, const struct sockaddr *, socklen_t) __DARWIN_ALIAS_C(sendto);
int	setsockopt(int, int, int, const void *, socklen_t);
int	shutdown(int, int);
int	sockatmark(int);
int	socketpair(int, int, int, int *) __DARWIN_ALIAS(socketpair);
int	sendfile(int, int, off_t, off_t *, struct sf_hdtr *, int);

void	pfctlinput(int, struct sockaddr *);
int connectx(int , const sa_endpoints_t *, sae_associd_t, unsigned int,
    const struct iovec *, unsigned int, size_t *, sae_connid_t *);
int disconnectx(int , sae_associd_t, sae_connid_t);*/

//Old Pointers
int (*old_socket)(int domain, int type, int protocol);
int	(*old_accept)(int, struct sockaddr * __restrict, socklen_t * __restrict)

//New Functions
int new_socket(int domain, int type, int protocol){
	int descriptor=old_socket(domain,type,protocol);
	if(WTShouldLog){
		WTInit(@"Socket",@"socket");
		WTAdd([NSNumber numberWithInt:domain],@"Domain");
		WTAdd([NSNumber numberWithInt:type],@"Type");
		WTAdd([NSNumber numberWithInt:protocol],@"Protocol");
		WTReturn([NSNumber numberWithInt:descriptor]);
		WTSave;
		WTRelease;

	}
return descriptor;

}
#ifdef PROTOTYPE
int	accept(int, struct sockaddr * __restrict, socklen_t * __restrict){

return 0;
}
#endif


extern void init_Socket_hook() {
    MSHookFunction((void*)socket,(void*)new_socket, (void**)&old_socket);
}

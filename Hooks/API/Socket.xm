#import "../SharedDefine.pch"
#import <sys/socket.h>

/*
ssize_t	recv(int, void *, size_t, int) __DARWIN_ALIAS_C(recv);
ssize_t	send(int, const void *, size_t, int) __DARWIN_ALIAS_C(send);

int	getpeername(int, struct sockaddr * __restrict, socklen_t * __restrict)
		__DARWIN_ALIAS(getpeername);
int	getsockname(int, struct sockaddr * __restrict, socklen_t * __restrict)
		__DARWIN_ALIAS(getsockname);
int	getsockopt(int, int, int, void * __restrict, socklen_t * __restrict);
ssize_t	recvfrom(int, void *, size_t, int, struct sockaddr * __restrict,
		socklen_t * __restrict) __DARWIN_ALIAS_C(recvfrom);
ssize_t	recvmsg(int, struct msghdr *, int) __DARWIN_ALIAS_C(recvmsg);
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
int	(*old_accept)(int, struct sockaddr * __restrict, socklen_t * __restrict);
int	(*old_bind)(int, struct sockaddr *, socklen_t);
int	(*old_connect)(int, const struct sockaddr *, socklen_t);
int	(*old_listen)(int, int);

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
int	new_accept(int newFileDesc, struct sockaddr * addr, socklen_t * addrlength){
	int retVal=0;
	if(WTShouldLog){
		WTInit(@"Socket",@"accept");
		WTAdd([NSNumber numberWithInt:newFileDesc],@"NewFileDescriptor");
		WTAdd([NSNumber numberWithUnsignedInt:addr->sa_len],@"Addr->TotalLength(addr->sa_len)");
		WTAdd([NSNumber numberWithUnsignedShort:addr->sa_family],@"Addr->AddressFamily(addr->sa_family)");
		WTAdd([NSData dataWithBytes:&addr->sa_data length:14],@"Addr->AddrValue(addr->sa_data[14])");
		WTAdd([NSNumber numberWithUnsignedShort:*addrlength],@"addrlength");

		retVal=old_accept(newFileDesc,addr,addrlength);
		WTReturn([NSNumber numberWithInt:retVal]);
		WTSave;
		WTRelease;

	}
	else{
	retVal=old_accept(newFileDesc,addr,addrlength);
	}

	return retVal;
}
int	new_bind(int A, struct sockaddr * addr, socklen_t addrlength){
	int retVal=0;
	if(WTShouldLog){
		WTInit(@"Socket",@"bind");
		WTAdd([NSNumber numberWithUnsignedInt:addr->sa_len],@"Addr->TotalLength(addr->sa_len)");
		WTAdd([NSNumber numberWithUnsignedShort:addr->sa_family],@"Addr->AddressFamily(addr->sa_family)");
		WTAdd([NSData dataWithBytes:&addr->sa_data length:14],@"Addr->AddrValue(addr->sa_data[14])");
		WTAdd([NSNumber numberWithUnsignedShort:addrlength],@"addrlength");
		retVal=old_bind(A,addr,addrlength);
		WTReturn([NSNumber numberWithInt:retVal]);
		WTSave;
		WTRelease;

	}
	else{
		retVal=old_bind(A,addr,addrlength);
	}
	return retVal;

}
int	new_connect(int sockfd, const struct sockaddr *addr,
                   socklen_t addrlen){
	int retVal=0;
	if(WTShouldLog){
		WTInit(@"Socket",@"connect");
		WTAdd([NSNumber numberWithUnsignedShort:sockfd],@"SocketFileDescriptor");
		WTAdd([NSNumber numberWithUnsignedInt:addr->sa_len],@"Addr->TotalLength(addr->sa_len)");
		WTAdd([NSNumber numberWithUnsignedShort:addr->sa_family],@"Addr->AddressFamily(addr->sa_family)");
		WTAdd([NSData dataWithBytes:&addr->sa_data length:14],@"Addr->AddrValue(addr->sa_data[14])");
		WTAdd([NSNumber numberWithUnsignedShort:addrlen],@"addrlength");
		retVal=old_connect(sockfd,addr,addrlen);
		WTReturn([NSNumber numberWithInt:retVal]);
		WTSave;
		WTRelease;

	}
	else{
		retVal=old_connect(sockfd,addr,addrlen);
	}
	return retVal;


}
int	new_listen(int sockfd, int backlog){
	int retVal=0;
	if(WTShouldLog){
		WTInit(@"Socket",@"listen");
		WTAdd([NSNumber numberWithUnsignedInt:sockfd],@"SocketFileDescriptor");
		WTAdd([NSNumber numberWithUnsignedInt:backlog],@"BackLog");
		retVal=old_listen(sockfd,backlog);
		WTReturn([NSNumber numberWithInt:retVal]);
		WTSave;
		WTRelease;

	}
	else{
		retVal=old_listen(sockfd,backlog);
	}
	return retVal;
}
extern void init_Socket_hook() {
    WTHookFunction((void*)socket,(void*)new_socket, (void**)&old_socket);
    WTHookFunction((void*)accept,(void*)new_accept, (void**)&old_accept);
    WTHookFunction((void*)bind,(void*)new_bind, (void**)&old_bind);
    WTHookFunction((void*)connect,(void*)new_connect, (void**)&old_connect);
    WTHookFunction((void*)listen,(void*)new_listen, (void**)&old_listen);
}

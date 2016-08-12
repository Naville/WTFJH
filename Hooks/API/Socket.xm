#import "../SharedDefine.pch"
#import <sys/socket.h>
#import <arpa/inet.h>
/*

int	getpeername(int, struct sockaddr * __restrict, socklen_t * __restrict)
		__DARWIN_ALIAS(getpeername);
int	getsockname(int, struct sockaddr * __restrict, socklen_t * __restrict)
		__DARWIN_ALIAS(getsockname);
int	getsockopt(int, int, int, void * __restrict, socklen_t * __restrict);
int	setsockopt(int, int, int, const void *, socklen_t);
int	shutdown(int, int);
int	sockatmark(int);
int	socketpair(int, int, int, int *) __DARWIN_ALIAS(socketpair);
int	sendfile(int, int, off_t, off_t *, struct sf_hdtr *, int);

void	pfctlinput(int, struct sockaddr *);
int connectx(int , const sa_endpoints_t *, sae_associd_t, unsigned int,
    const struct iovec *, unsigned int, size_t *, sae_connid_t *);
int disconnectx(int , sae_associd_t, sae_connid_t);*/

static NSString* get_ip_str(const struct sockaddr *sa)
{
	if(sa==NULL){
		return @"WTFJH-NULL struct sockaddr";
	}
	int maxlen=SOCK_MAXADDRLEN;
	char* s=(char*)malloc(SOCK_MAXADDRLEN);
	//Shamefully Borrowed from http://beej.us/guide/bgnet/output/html/multipage/inet_ntopman.html
    switch(sa->sa_family) {
        case AF_INET:
            inet_ntop(AF_INET, &(((struct sockaddr_in *)sa)->sin_addr),
                    s, maxlen);
            break;

        case AF_INET6:
            inet_ntop(AF_INET6, &(((struct sockaddr_in6 *)sa)->sin6_addr),
                    s, maxlen);
            break;

        default:
            s=NULL;
    }

   if(s!=NULL){
   		return [NSString stringWithUTF8String:s];
   }
   else{
   	return @"WTFJH-Unsupported sa_family";
   }
}

static NSMutableDictionary* GetInfoFormsghdr(struct msghdr* message){
	NSMutableDictionary* RetDict=[NSMutableDictionary dictionary];
	if(message==NULL){
		[RetDict setObject:@"WTFJH-message==NULL" forKey:@"Error"];
		return RetDict;

	}
	if(message->msg_name!=NULL){
		[RetDict setObject:get_ip_str((const struct sockaddr *)message->msg_name) forKey:@"MessageName"];
	}
	NSMutableArray* iovecArray=[[NSMutableArray array] autorelease];
	if(message->msg_iov!=NULL && message->msg_iovlen>0){
		for (int i = 0; i < message->msg_iovlen; i++) {
			struct iovec currentIOVEC=message->msg_iov[i];
			[iovecArray addObject:[NSData dataWithBytes:currentIOVEC.iov_base length:currentIOVEC.iov_len]];
        }
    }
    [RetDict setObject:iovecArray forKey:@"IOVEC"];
	[RetDict setObject:[NSData dataWithBytes:message->msg_control length:message->msg_controllen] forKey:@"Data"];
	[RetDict setObject:[NSNumber numberWithInt:message->msg_flags] forKey:@"flags"];
	return RetDict;
}

//Old Pointers
int (*old_socket)(int domain, int type, int protocol);
int	(*old_accept)(int, struct sockaddr * __restrict, socklen_t * __restrict);
int	(*old_bind)(int, struct sockaddr *, socklen_t);
int	(*old_connect)(int, const struct sockaddr *, socklen_t);
int	(*old_listen)(int, int);
ssize_t (*old_recv)(int socket, void *buffer, size_t length, int flags);
ssize_t (*old_recvfrom)(int socket, void *buffer, size_t length,int flags,struct sockaddr *address,socklen_t * addresslen);
ssize_t (*old_recvmsg)(int socket, struct msghdr *message, int flags);
ssize_t (*old_send)(int socket, const void *buffer, size_t length, int flags);
ssize_t (*old_sendmsg)(int socket, const struct msghdr *message, int flags);
ssize_t (*old_sendto)(int socket, const void *buffer, size_t length, int flags,const struct sockaddr *dest_addr, socklen_t dest_len);
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
		WTAdd([NSNumber numberWithUnsignedInt:addr->sa_len],@"SocketAddressTotalLength");
		WTAdd([NSNumber numberWithUnsignedShort:addr->sa_family],@"SocketAddressAddressFamily");
		WTAdd(get_ip_str(addr),@"Address");
		WTAdd([NSNumber numberWithUnsignedShort:*addrlength],@"SocketAddressLength");

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
		WTAdd([NSNumber numberWithUnsignedInt:addr->sa_len],@"SocketAddressTotalLength");
		WTAdd([NSNumber numberWithUnsignedShort:addr->sa_family],@"SocketAddressAddressFamily");
		WTAdd(get_ip_str(addr),@"Address");
		WTAdd([NSNumber numberWithUnsignedShort:addrlength],@"SocketAddressLength");
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
		WTAdd([NSNumber numberWithUnsignedInt:addr->sa_len],@"SocketAddressTotalLength");
		WTAdd([NSNumber numberWithUnsignedShort:addr->sa_family],@"SocketAddressAddressFamily");
		WTAdd(get_ip_str(addr),@"Address");
		WTAdd([NSNumber numberWithUnsignedShort:addrlen],@"SocketAddressLength");
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
ssize_t new_recv(int socket, void *buffer, size_t length, int flags){
	ssize_t retVal=0;
	if(WTShouldLog){
		retVal=old_recv(socket,buffer,length,flags);
		WTInit(@"Socket",@"recv");
		WTAdd([NSNumber numberWithUnsignedInt:socket],@"SocketFileDescriptor");
		WTAdd([NSData dataWithBytes:buffer length:length],@"Data");
		WTAdd([NSNumber numberWithInt:flags],@"Flags");
		WTReturn([NSNumber numberWithLong:retVal]);
		WTSave;
		WTRelease;

	}
	else{
		retVal=old_recv(socket,buffer,length,flags);
	}
	return retVal;
}
ssize_t new_recvfrom(int socket, void *buffer, size_t length, int flags,struct sockaddr *address, socklen_t *address_len){
	ssize_t retVal=0;
	if(WTShouldLog){
		retVal=old_recvfrom(socket,buffer,length,flags,address,address_len);
		WTInit(@"Socket",@"recvfrom");
		WTAdd([NSNumber numberWithUnsignedInt:socket],@"SocketFileDescriptor");
		WTAdd([NSData dataWithBytes:buffer length:length],@"Data");
		WTAdd([NSNumber numberWithInt:flags],@"Flags");
		WTAdd(get_ip_str(address),@"Address");
		WTReturn([NSNumber numberWithLong:retVal]);
		WTSave;
		WTRelease;

	}
	else{
		retVal=old_recvfrom(socket,buffer,length,flags,address,address_len);
	}
	return retVal;



}
ssize_t new_recvmsg(int socket, struct msghdr *message, int flags){
	ssize_t retVal=0;
	if(WTShouldLog){
		retVal=old_recvmsg(socket,message,flags);
		WTInit(@"Socket",@"recvmsg");
		WTAdd([NSNumber numberWithUnsignedInt:socket],@"SocketFileDescriptor");

		WTAdd([NSNumber numberWithInt:flags],@"Flags");
		WTAdd(GetInfoFormsghdr(message),@"Message");
		WTReturn([NSNumber numberWithLong:retVal]);
		WTSave;
		WTRelease;

	}
	else{
		retVal=old_recvmsg(socket,message,flags);
	}
	return retVal;

}
ssize_t new_send(int socket, const void *buffer, size_t length, int flags){
	ssize_t retVal=0;
	if(WTShouldLog){
		retVal=old_send(socket,buffer,length,flags);
		WTInit(@"Socket",@"send");
		WTAdd([NSNumber numberWithUnsignedInt:socket],@"SocketFileDescriptor");
		WTAdd([NSData dataWithBytes:buffer length:length],@"Data");
		WTAdd([NSNumber numberWithInt:flags],@"Flags");
		WTReturn([NSNumber numberWithLong:retVal]);
		WTSave;
		WTRelease;

	}
	else{
		retVal=old_send(socket,buffer,length,flags);
	}
	return retVal;


}
ssize_t new_sendmsg(int socket, struct msghdr *message, int flags){
	ssize_t retVal=0;
	if(WTShouldLog){
		retVal=old_sendmsg(socket,message,flags);
		WTInit(@"Socket",@"sendmsg");
		WTAdd([NSNumber numberWithUnsignedInt:socket],@"SocketFileDescriptor");
		WTAdd(GetInfoFormsghdr(message),@"Message");
		WTAdd([NSNumber numberWithInt:flags],@"Flags");
		WTReturn([NSNumber numberWithLong:retVal]);
		WTSave;
		WTRelease;

	}
	else{
		retVal=old_sendmsg(socket,message,flags);
	}
	return retVal;


}
ssize_t new_sendto(int socket, const void *buffer, size_t length, int flags,
         struct sockaddr *dest_addr, socklen_t dest_len){
	ssize_t retVal=0;
	if(WTShouldLog){
		retVal=old_sendto(socket,buffer,length,flags,dest_addr,dest_len);
		WTInit(@"Socket",@"sendto");
		WTAdd([NSNumber numberWithUnsignedInt:socket],@"SocketFileDescriptor");
		WTAdd([NSData dataWithBytes:buffer length:length],@"Data");
		WTAdd([NSNumber numberWithInt:flags],@"Flags");
		WTAdd(get_ip_str(dest_addr),@"Address");
		WTReturn([NSNumber numberWithLong:retVal]);

		WTSave;
		WTRelease;

	}
	else{
		retVal=old_sendto(socket,buffer,length,flags,dest_addr,dest_len);
	}
	return retVal;


}
extern void init_Socket_hook() {
	//Some of these functions are too short to use MSHookFunction
   WTFishHookSymbols("recv",(void*)new_recv, (void**)&old_recv);
   WTFishHookSymbols("recvfrom",(void*)new_recvfrom, (void**)&old_recvfrom);
   WTFishHookSymbols("recvmsg",(void*)new_recvmsg, (void**)&old_recvmsg);
   WTFishHookSymbols("socket",(void*)new_socket, (void**)&old_socket);
   WTFishHookSymbols("accept",(void*)new_accept, (void**)&old_accept);
   WTFishHookSymbols("bind",(void*)new_bind, (void**)&old_bind);
   WTFishHookSymbols("connect",(void*)new_connect, (void**)&old_connect);
   WTFishHookSymbols("listen",(void*)new_listen, (void**)&old_listen);
   WTFishHookSymbols("send",(void*)new_send, (void**)&old_send);
   WTFishHookSymbols("sendmsg",(void*)new_sendmsg, (void**)&old_sendmsg);
   WTFishHookSymbols("sendto",(void*)new_sendto, (void**)&old_sendto);

}

#import "../SharedDefine.pch"
#import <mach-o/getsect.h>

char * (*old_getsectdata)(const char *segname,const char *sectname,unsigned long *size);
const struct section * (*old_getsectbyname)(const char *segname,const char *sectname);
const struct segment_command * (*old_getsegbyname)(const char *segname);
char * (*old_getsectdatafromheader_64)(const struct mach_header_64 *mhp,const char *segname,const char *sectname,uint64_t *size);
char * (*old_getsectiondata)(const struct mach_header *mhp,const char *segname,const char *sectname,unsigned long *size);
char * (*old_getsegmentdata)(const struct mach_header_64 *mhp,const char *segname,unsigned long *size);
const struct section * (*old_getsectbynamefromheader)(const struct mach_header *mhp,const char *segname,const char *sectname);
/*extern char *getsectdatafromFramework(
    const char *FrameworkName,
    const char *segname,
    const char *sectname,
    unsigned long *size);

extern unsigned long get_end(void);
extern unsigned long get_etext(void);
extern unsigned long get_edata(void);

 * Runtime interfaces for 32-bit Mach-O programs.

extern uint8_t *getsegmentdata(
    const struct mach_header *mhp,
    const char *segname,
    unsigned long *size);

Runtime interfaces for 64-bit Mach-O programs.
extern const struct section_64 *getsectbyname(
    const char *segname,
    const char *sectname);

extern uint8_t *getsectiondata(
    const struct mach_header_64 *mhp,
    const char *segname,
    const char *sectname,
    unsigned long *size);

extern const struct segment_command_64 *getsegbyname(
    const char *segname);

 * Interfaces for tools working with 32-bit Mach-O files.
extern char *getsectdatafromheader(
    const struct mach_header *mhp,
    const char *segname,
    const char *sectname,
    uint32_t *size);

extern const struct section *getsectbynamefromheaderwithswap(
    struct mach_header *mhp,
    const char *segname,
    const char *sectname,
    int fSwap);

extern const struct section_64 *getsectbynamefromheader_64(
    const struct mach_header_64 *mhp,
    const char *segname,
    const char *sectname);

extern const struct section *getsectbynamefromheaderwithswap_64(
    struct mach_header_64 *mhp,
    const char *segname,
    const char *sectname,
    int fSwap);
*/
char* new_getsectdata(const char *segname,const char *sectname,unsigned long *size){
	char* ret=old_getsectdata(segname,sectname,size);
	if(WTShouldLog){
		NSString* NSSegName=[NSString stringWithUTF8String:segname];
		NSString* NSSectName=[NSString stringWithUTF8String:sectname];
		NSData* SectData=[NSData dataWithBytes:ret length:*size];
		WTInit(@"Mach-O",@"getsectdata");
		WTAdd(NSSegName,@"SegmentName");
		WTAdd(NSSectName,@"SectionName");
		WTAdd(SectData,@"SectionData");
        WTSave;
        WTRelease;
		[NSSectName release];
		[NSSegName release];
		[SectData release];

	}
	return ret;

}
const struct section * new_getsectbyname(const char *segname,const char *sectname){
    if(WTShouldLog){
        NSString* NSSegName=[NSString stringWithUTF8String:segname];
        NSString* NSSectName=[NSString stringWithUTF8String:sectname];
        WTInit(@"Mach-O",@"getsectbyname");
        WTAdd(NSSegName,@"SegmentName");
        WTAdd(NSSectName,@"SectionName");
        WTSave;
        WTRelease;
        [NSSectName release];
        [NSSegName release];    
    }
    return old_getsectbyname(segname,sectname);

}
const struct segment_command * new_getsegbyname(const char *segname){

    if(WTShouldLog){
        NSString* NSSegName=[NSString stringWithUTF8String:segname];
        WTInit(@"Mach-O",@"getsegbyname");
        WTAdd(NSSegName,@"SegmentName");
        WTSave;
        WTRelease;        
        [NSSegName release];    
    }
    return old_getsegbyname(segname);
}
char * new_getsectdatafromheader_64(const struct mach_header_64 *mhp,const char *segname,const char *sectname,uint64_t *size){
    char* ret=old_getsectdatafromheader_64(mhp,segname,sectname,size);
    if(WTShouldLog){
        NSString* NSSegName=[NSString stringWithUTF8String:segname];
        NSString* NSSectName=[NSString stringWithUTF8String:sectname];
        NSData* SectData=[NSData dataWithBytes:ret length:*size];
        NSString* HeaderAddress=[NSString stringWithFormat:@"%p",mhp];
        WTInit(@"Mach-O",@"getsectdata");
        WTAdd(NSSegName,@"SegmentName");
        WTAdd(NSSectName,@"SectionName");
        WTAdd(SectData,@"SectionData");
        WTAdd(HeaderAddress,@"HeaderAddress");
        WTSave;
        WTRelease;
        [NSSectName release];
        [NSSegName release];
        [SectData release];
        [HeaderAddress release];
    }
    return ret;

}
char * new_getsectiondata(const struct mach_header *mhp,const char *segname,const char *sectname,unsigned long *size){
    char* ret=old_getsectiondata(mhp,segname,sectname,size);
    if(WTShouldLog){
        NSString* NSSegName=[NSString stringWithUTF8String:segname];
        NSString* NSSectName=[NSString stringWithUTF8String:sectname];
        NSData* SectData=[NSData dataWithBytes:ret length:*size];
        NSString* HeaderAddress=[NSString stringWithFormat:@"%p",mhp];
        WTInit(@"Mach-O",@"getsectdata");
        WTAdd(NSSegName,@"SegmentName");
        WTAdd(NSSectName,@"SectionName");
        WTAdd(SectData,@"SectionData");
        WTAdd(HeaderAddress,@"HeaderAddress");
        WTSave;
        WTRelease;
        [NSSectName release];
        [NSSegName release];
        [SectData release];
        [HeaderAddress release];

    }
    return ret;    


}
char * new_getsegmentdata(const struct mach_header_64 *mhp,const char *segname,unsigned long *size){
    char* ret=old_getsegmentdata(mhp,segname,size);
    if(WTShouldLog){
        NSString* NSSegName=[NSString stringWithUTF8String:segname];
        NSData* SegData=[NSData dataWithBytes:ret length:*size];
        NSString* HeaderAddress=[NSString stringWithFormat:@"%p",mhp];
        WTInit(@"Mach-O",@"getsegmentdata");
        WTAdd(NSSegName,@"SegmentName");
        WTAdd(SegData,@"SegmentData");
        WTAdd(HeaderAddress,@"HeaderAddress");
        WTSave;
        WTRelease;       
        [NSSegName release];
        [SegData release];
        [HeaderAddress release];
    }
    return ret;  


}
const struct section * new_getsectbynamefromheader(const struct mach_header *mhp,const char *segname,const char *sectname){

   const struct section* ret=old_getsectbynamefromheader(mhp,segname,sectname);
    if(WTShouldLog){
        NSString* NSSegName=[NSString stringWithUTF8String:segname];
        NSString* NSSectName=[NSString stringWithUTF8String:sectname];
        NSString* HeaderAddress=[NSString stringWithFormat:@"%p",mhp];
        WTInit(@"Mach-O",@"getsegmentdata");
        WTAdd(NSSegName,@"SegmentName");
        WTAdd(NSSectName,@"SectionName");
        WTAdd(HeaderAddress,@"HeaderAddress");
        [NSSegName release];
        [HeaderAddress release];
        [NSSectName release];
        WTSave;
        WTRelease;
    }
    return ret;  




};

//Init Hooks
extern void init_MachO_hook() {
	MSHookFunction((void*)getsectdata,(void*)new_getsectdata, (void**)&old_getsectdata);
    MSHookFunction((void*)getsectbyname,(void*)new_getsectbyname, (void**)&old_getsectbyname);
    MSHookFunction((void*)getsegbyname,(void*)new_getsegbyname, (void**)&old_getsegbyname);
    MSHookFunction((void*)getsectdatafromheader_64,(void*)new_getsectdatafromheader_64, (void**)&old_getsectdatafromheader_64);
    MSHookFunction((void*)getsectiondata,(void*)new_getsectiondata, (void**)&old_getsectiondata);
    MSHookFunction((void*)getsegmentdata,(void*)new_getsegmentdata, (void**)&old_getsegmentdata);
    MSHookFunction((void*)getsectbynamefromheader,(void*)new_getsectbynamefromheader, (void**)&old_getsectbynamefromheader);
}


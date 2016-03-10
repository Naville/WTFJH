#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <mach-o/fat.h>
NSMutableArray* SplitMachO(NSString* Path) {
    @autoreleasepool {
        NSMutableArray* ArchDataArray=[NSMutableArray array];
        NSData* InputData=[NSData dataWithContentsOfFile:Path];
        NSFileHandle* NSFH=[NSFileHandle fileHandleForReadingAtPath:Path];
        char* rawData=(char*)[InputData bytes];        
        struct fat_header *FatHeader=(struct fat_header*)rawData;
        if(FatHeader->magic==FAT_CIGAM||FatHeader->magic==FAT_MAGIC){
           // NSData* FatHeaderData=[NSData dataWithBytes:FatHeader length:sizeof(struct fat_header)];
            
            int numberOfFatArch=CFSwapInt32(FatHeader->nfat_arch);
            for(int i=0;i<numberOfFatArch;i++){
            [NSFH seekToFileOffset:sizeof(struct fat_header)+i*sizeof(struct fat_arch)];
                struct fat_arch* FatArch=(struct fat_arch*)[[NSFH readDataOfLength:sizeof(struct fat_arch)] bytes];
                NSData* currentArchData;
                if(FatArch->cputype==0x0){
                    printf("Wrong Arch");
                    break;
                    
                    
                }
                
                //Solve Endian Issue
                
                if((FatHeader->magic)==FAT_CIGAM){
                    printf("Size:0x%x Offset:0x%x\n",CFSwapInt32(FatArch->size),CFSwapInt32(FatArch->offset));
                    [NSFH seekToFileOffset:CFSwapInt32(FatArch->offset)];
                    
                    currentArchData=[NSFH readDataOfLength:CFSwapInt32(FatArch->size)];
                    
                    
                    NSLog(@"Current Size Data:0x%lx\n",(unsigned long)currentArchData.length);
                    
                    [ArchDataArray addObject:currentArchData];
                    
                }
                else if((FatHeader->magic)==FAT_MAGIC){
                    printf("Size:%x Offset:%x\n",FatArch->size,FatArch->offset);
                    [NSFH seekToFileOffset:FatArch->offset];
                    currentArchData=[NSFH readDataOfLength:FatArch->size];
                    
                    
                    NSLog(@"Current Size Data:0x%lx\n",(unsigned long)currentArchData.length);

                    [ArchDataArray addObject:currentArchData];
                    
                    
                }

                
                
            }
            
        }
        else{
            [ArchDataArray addObject:InputData];
            NSLog(@"Thin Binary");
        }
        return ArchDataArray;
        
    }
}
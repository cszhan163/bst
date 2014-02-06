//
//  jqEncode.m
//  guosen
//
//  Created by  on 12-11-2.
//  Copyright (c) 2012年 JianQiao. All rights reserved.
//
#include <string.h>
#include <stdio.h>
#import "jqEncode.h"
#import "NSData+Gzip.h"
#include <iostream>
char* jqEncrypt(const char*_src);
char* jqDecrypt(const char*_src);

@implementation jqEncode


#include <string.h>
#include <stdio.h>


const char base[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="; 
char* base64_encode(const char* data, int data_len); 
char *base64_decode(const char* data, int data_len); 
static char find_pos(char ch); 
char* exchange(const char* _src);
char* jqEncrypt(const char*_src, int _len);
char* jqDecrypt(const char*_src);


-(NSString *)encodeString:(NSString *)src{

    NSData* data=[src dataUsingEncoding:NSUTF8StringEncoding];
    NSData* compressedData=[data gzipDeflate];
    int len=[compressedData length];

    const char* cSrc=(const char*)[compressedData bytes];


    char* enc=jqEncrypt((const char*)cSrc,len);
    if (enc==NULL) return NULL;
    
    NSString* dest=[[NSString alloc]initWithBytes:enc length:strlen(enc) encoding:NSASCIIStringEncoding];
    free(enc);
    return [dest autorelease];
}
-(NSString *)decodeString:(NSString *)src{
    const char* cSrc=[src cStringUsingEncoding:NSASCIIStringEncoding];
    int csrc_len = (strlen(cSrc) / 4) * 3;
    char* dec=jqDecrypt(cSrc);
    if (dec==NULL) {
        return nil;
    }

    NSData* data=[NSData dataWithBytes:dec length:csrc_len];
    NSData* decompressedData=[data gzipInflate];
    NSString* dest=[[NSString alloc]initWithData:decompressedData encoding:NSUTF8StringEncoding];
    
    free(dec);
    return [dest autorelease];
}

char* jqEncrypt(const char*_src, int _len)
{
    if (_src==NULL) return NULL;

	char* enc=base64_encode(_src,_len);

	char* dest=exchange(enc);
	free(enc);
	return dest;
}
char* jqDecrypt(const char*_src)
{
    if (_src==NULL) return NULL;
	char* dec=exchange(_src);
	int len=strlen(dec);
	char* dest=base64_decode(dec,len);
	
	free(dec);
	return dest;
}



char* exchange(const char* _src){
    
    if (_src==NULL) return NULL;
    
    unsigned long len=strlen(_src);
    const char specialChat[10]={'A','M','W','c','3','n','D','5','g','S'};
    
    
    char* dest=(char*)malloc(sizeof(char)*len+1);
    
    memset(dest, '\0', sizeof(char)*len+1);
    
    if (len>=2) {
        
        for (unsigned long i=0 ;i<len/2 ;i++) {
            
            *(dest+2*i)=*(_src+2*i+1);
            
            *(dest+2*i+1)=*(_src+2*i);
            
            
        }
        
    }
    
    if (len%2==1) {
        
        
        *(dest+len-1)=*(_src+len-1);
        
        
    }
    
    for (unsigned long i=0; i<len; i++) {
        
        for (unsigned short j=0; j<10; j++) {
            
            if (*(dest+i)==specialChat[j]) {
                
                *(dest+i)=specialChat[9-j];
                
                break;
                
            }
            
        }
        
    }
    
    
    return dest;
    
}


char *base64_encode(const char* data, int data_len) 
{ 
    //int data_len = strlen(data); 
    int prepare = 0; 
    int ret_len; 
    int temp = 0; 
    char *ret = NULL; 
    char *f = NULL; 
    int tmp = 0; 
    char changed[4]; 
    int i = 0; 
    ret_len = data_len / 3; 
    temp = data_len % 3; 
    if (temp > 0) 
    { 
        ret_len += 1; 
    } 
    ret_len = ret_len*4 + 1; 
    ret = (char *)malloc(ret_len); 
    
    if ( ret == NULL) 
    { 
        printf("No enough memory.\n"); 
        exit(0); 
    } 
    memset(ret, 0, ret_len); 
    f = ret; 
    while (tmp < data_len) 
    { 
        temp = 0; 
        prepare = 0; 
        memset(changed, '\0', 4); 
        while (temp < 3) 
        { 
            //printf("tmp = %d\n", tmp); 
            if (tmp >= data_len) 
            { 
                break; 
            } 
            prepare = ((prepare << 8) | (data[tmp] & 0xFF)); 
            tmp++; 
            temp++; 
        } 
        prepare = (prepare<<((3-temp)*8)); 
        //printf("before for : temp = %d, prepare = %d\n", temp, prepare); 
        for (i = 0; i < 4 ;i++ ) 
        { 
            if (temp < i) 
            { 
                changed[i] = 0x40; 
            } 
            else 
            { 
                changed[i] = (prepare>>((3-i)*6)) & 0x3F; 
            } 
            *f = base[changed[i]]; 
            //printf("%.2X", changed[i]); 
            f++; 
        } 
    } 
    *f = '\0'; 
    
    return ret; 
    
} 
/* */ 
static char find_pos(char ch)   
{ 
    char *ptr = (char*)strrchr(base, ch);//the last position (the only) in base[] 
    return (ptr - base); 
} 
/* */ 
char *base64_decode(const char *data, int data_len) 
{ 
    int ret_len = (data_len / 4) * 3; 
    int equal_count = 0; 
    char *ret = NULL; 
    char *f = NULL; 
    int tmp = 0; 
    int temp = 0; 
    char need[3]; 
    int prepare = 0; 
    int i = 0; 
    if (*(data + data_len - 1) == '=') 
    { 
        equal_count += 1; 
    } 
    if (*(data + data_len - 2) == '=') 
    { 
        equal_count += 1; 
    } 
    if (*(data + data_len - 3) == '=') 
    {//seems impossible 
        equal_count += 1; 
    } 
    switch (equal_count) 
    { 
        case 0: 
            ret_len += 4;//3 + 1 [1 for NULL] 
            break; 
        case 1: 
            ret_len += 4;//Ceil((6*3)/8)+1 
            break; 
        case 2: 
            ret_len += 3;//Ceil((6*2)/8)+1 
            break; 
        case 3: 
            ret_len += 2;//Ceil((6*1)/8)+1 
            break; 
    } 
    ret = (char *)malloc(ret_len); 
    if (ret == NULL) 
    { 
        printf("No enough memory.\n"); 
        exit(0); 
    } 
    memset(ret, 0, ret_len); 
    f = ret; 
    while (tmp < (data_len - equal_count)) 
    { 
        temp = 0; 
        prepare = 0; 
        memset(need, 0, 4); 
        while (temp < 4) 
        { 
            if (tmp >= (data_len - equal_count)) 
            { 
                break; 
            } 
            prepare = (prepare << 6) | (find_pos(data[tmp])); 
            temp++; 
            tmp++; 
        } 
        prepare = prepare << ((4-temp) * 6); 
        for (i=0; i<3 ;i++ ) 
        { 
            if (i == temp) 
            { 
                break; 
            } 
            *f = (char)((prepare>>((2-i)*8)) & 0xFF); 
            f++; 
        } 
    } 
    *f = '\0'; 
    return ret; 
}

@end

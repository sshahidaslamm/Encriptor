//
//  SAEncriptor.m
//  
//
//  Created by Shahid Aslam on 3/10/15.
//  Copyright (c) 2015 SystemsLtd. All rights reserved.
//

#import "SAEncriptor.h"

@implementation SAEncriptor

//Encodes using cipher mode: DESede/CBC/PKCS5Padding

+ (NSString*) doCipherIn3DesWith:(NSString*)plainText enc:(CCOperation)encryptOrDecrypt{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSString *base64EncodedString = [[plainText dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
        NSData *encryptData = [[NSData alloc]initWithBase64EncodedString:base64EncodedString options:0];
        plainTextBufferSize = [encryptData length];
        vplainText = [encryptData bytes];
    }
    else
    {
        plainTextBufferSize = [plainText length];
        vplainText = (const void *) [plainText UTF8String];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const unsigned char *keyString = (const unsigned char *)[@"THISWILLBEYOURKEY"  cStringUsingEncoding: NSUTF8StringEncoding];
    const unsigned char *initializeVactorString = (const unsigned char *)[@"ANYWORD" cStringUsingEncoding: NSUTF8StringEncoding];
    
    uint8_t iv[kCCBlockSize3DES];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       keyString,
                       kCCKeySize3DES,
                       initializeVactorString,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    else{
        if (ccStatus == kCCParamError) return @"PARAM ERROR";
        else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
        else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
        else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
        else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
        else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
    }
    
    NSString *result;
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [ [NSString alloc] initWithData: [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSASCIIStringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [NSString stringToHex2:[[NSString alloc] initWithData:myData encoding:NSASCIIStringEncoding]];
    }
    NSLog(@"%@",result);
    return result   ;
}


@end

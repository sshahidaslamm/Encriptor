//
//  SAEncriptor.h
//  
//
//  Created by Shahid Aslam on 3/10/15.
//  Copyright (c) 2015 SystemsLtd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+hex.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@interface SAEncriptor : NSObject

+ (NSString*) doCipherIn3DesWith:(NSString*)plainText enc:(CCOperation)encryptOrDecrypt;
    
@end

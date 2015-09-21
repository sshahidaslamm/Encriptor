//
//  NSString+hex.h
//  
//
//  Created by Shahid Aslam on 3/9/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (hex)

+ (NSString *) stringFromHex:(NSString *)str;
+ (NSString *) stringToHex:(NSString *)str;
+ (NSString *) stringToHex2:(NSString *)str;

@end

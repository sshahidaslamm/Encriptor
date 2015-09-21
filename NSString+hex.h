//
//  NSString+hex.h
//  AMAF
//
//  Created by Shahid Aslam on 3/9/15.
//  Copyright (c) 2015 SystemsLtd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (hex)

+ (NSString *) stringFromHex:(NSString *)str;
+ (NSString *) stringToHex:(NSString *)str;
+ (NSString *) stringToHex2:(NSString *)str;

@end

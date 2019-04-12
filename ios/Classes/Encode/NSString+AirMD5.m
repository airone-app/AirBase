//
//  NSString+MD5.m
//  jiayoubao
//
//  Created by candela on 14-6-9.
//  Copyright (c) 2014年 jtjr99. All rights reserved.
//

#import "NSString+AirMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (AirMD5)

- (NSString *)air_MD5
{
    const char *ptr = [self UTF8String];
    
    if (self == nil || ptr == nil)
    {
        return nil;
    }
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", md5Buffer[i]];
    }
    
    return output;
}

@end

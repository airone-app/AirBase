//
// NSString+AirMD5.m
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

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

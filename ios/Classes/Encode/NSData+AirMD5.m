//
//  NSData.m
//  jiayoubao
//
//  Created by candela on 16/6/22.
//  Copyright © 2016年 jiayoubao. All rights reserved.
//

#import "NSData+AirMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5)

- (NSString *)air_MD5
{
    const char *ptr = (const char *)[self bytes];
    
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

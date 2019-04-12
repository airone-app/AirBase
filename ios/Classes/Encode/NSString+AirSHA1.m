//
//  NSString+SHA1.m
//  jiayoubao
//
//  Created by candela on 14-8-15.
//  Copyright (c) 2014年 jtjr99. All rights reserved.
//

#import "NSString+AirSHA1.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (AirSHA1)

- (NSString*)air_SHA1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end

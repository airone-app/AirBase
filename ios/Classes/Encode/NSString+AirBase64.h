//
// NSString+AirBase64.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSString (AirBase64)


/**
Use base64 to encode the string
*/
- (NSString *)air_base64Encode;

/**
Use base64 to decode the string
*/
- (NSString *)air_base64Decode;

// implement with GTMBase64
- (NSString *)GTMBase64Encode;
- (NSString *)GTMBase64Decode;

@end

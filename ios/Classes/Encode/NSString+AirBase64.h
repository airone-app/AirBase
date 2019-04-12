//
//  NSString+Base64.h
//  jiayoubao
//
//  Created by candela on 14-7-1.
//  Copyright (c) 2014年 jtjr99. All rights reserved.
//

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

//
// NSObject+AirEncode.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>



@interface NSDictionary (AirEncode)

- (NSString *)air_URLStringAppendParamToURL:(NSString *)URL;

- (NSString *)air_paramsString;

// 会对每一个参数做encode
- (NSString *)air_encodeParamsString;

@end





@interface NSString (AirEncode)


#pragma mark [ md5 ]

- (NSString *)air_md5;


#pragma mark [ url-encode ]

- (NSString *)air_URLEncodingUTF8String; // 编码URL
- (NSString *)air_URLDecodingUTF8String; // 解码URL

- (NSString *)air_URLParamEncoding;     // 编码参数
- (NSString *)air_URLParamDecoding;     // 解码参数

#pragma mark [ url-params ]


/**
 从url字符串中取指定的参数

 @param key 参数key
 @return 返回key对应的参数值
 */
- (NSString *)air_valueOfParam:(NSString *)key;

/**
 替换url字符串中指定的参数
 */
- (NSString *)air_replaceParamOfKey:(NSString *)key withValue:(NSString *)value;

/**
 *  参数Dictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)air_paramsDictionary;
- (NSDictionary *)air_decodeParamsDictionary;

/**
 *  URL添加
 *  @return URL
 */
- (NSString *)air_appendValue:(NSString *)value param:(NSString *)param;


/**
 *  URL删除参数
 *  @return URL
 */
- (NSString *)air_removeValue:(NSString *)value param:(NSString *)param;

/**
 *  URL删除参数
 *  @return URL
 */
- (NSString *)air_removeParam:(NSString *)param;

@end

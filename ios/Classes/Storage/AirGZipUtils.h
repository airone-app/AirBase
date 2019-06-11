//
// AirGZipUtils.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>

@interface AirGZipUtils : NSObject


/**
 压缩
 */
+ (NSData*)gzipData:(NSData*)pUncompressedData;


/**
 解压缩
 */
+ (NSData*)ungzipData:(NSData *)compressedData;

@end

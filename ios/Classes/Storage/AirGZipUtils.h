//
//  GZipUtils.h
//  jiayoubao
//
//  Created by candela on 16/6/22.
//  Copyright © 2016年 jiayoubao. All rights reserved.
//

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

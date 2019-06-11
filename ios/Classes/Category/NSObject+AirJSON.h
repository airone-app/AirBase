//
// NSObject+AirJSON.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>



@interface NSArray (AirJSON)

- (NSData *)air_JSON2Data;
- (NSString *)air_JSON2String;

@end


@interface NSDictionary (AirJSON)

- (NSData *)air_JSON2Data;
- (NSString *)air_JSON2String;

@end


@interface NSData (AirJSON)

- (id)air_data2JSON;

@end


@interface NSString (AirJSON)

- (id)air_string2JSON;

@end

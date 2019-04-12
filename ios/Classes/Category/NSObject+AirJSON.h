//
//  NSObject+JSON.h
//  jiayoubao
//
//  Created by candela on 14-7-8.
//  Copyright (c) 2014年 jtjr99. All rights reserved.
//

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

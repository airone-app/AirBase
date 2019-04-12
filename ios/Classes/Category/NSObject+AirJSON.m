//
//  NSObject+JSON.m
//  jiayoubao
//
//  Created by candela on 14-7-8.
//  Copyright (c) 2014年 jtjr99. All rights reserved.
//

#import "NSObject+AirJSON.h"


@implementation NSArray (AirJSON)

- (NSData *)air_JSON2Data
{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:kNilOptions error:&error];
    if (error != nil)
    {
        return nil;
    }
    return jsonData;
}

-(NSString *)air_JSON2String
{
    NSData *jsonData = [self air_JSON2Data];
    
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
}

@end


@implementation NSDictionary (AirJSON)

- (NSData *)air_JSON2Data
{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:kNilOptions error:&error];
    if (error != nil)
    {
        return nil;
    }
    return jsonData;
}

- (NSString *)air_JSON2String
{
    NSData *jsonData = [self air_JSON2Data];
    
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
}
@end


@implementation NSData (AirJSON)

- (id)air_data2JSON
{
    id dict = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableLeaves error:nil];
    return dict;
}

@end


@implementation NSString (AirJSON)

- (id)air_string2JSON
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data air_data2JSON];
}
@end


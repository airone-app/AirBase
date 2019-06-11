//
// GTMNSDictionary+URLArguments.m
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "GTMNSDictionary+URLArguments.h"
#import "GTMNSString+URLArguments.h"

@implementation NSDictionary (GTMNSDictionaryURLArgumentsAdditions)

- (NSString *)gtm_httpArgumentsString {
    NSMutableArray* arguments = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator* keyEnumerator = [self keyEnumerator];
    NSString* key;
    while ((key = [keyEnumerator nextObject])) {
        [arguments addObject:[NSString stringWithFormat:@"%@=%@",
                              [key gtm_stringByEscapingForURLArgument],
                              [[[self objectForKey:key] description] gtm_stringByEscapingForURLArgument]]];
    }
    
    return [arguments componentsJoinedByString:@"&"];
}

@end
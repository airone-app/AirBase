//
// GTMNSString+URLArguments.m
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

// MODIFIED by Keith Lazuka (klazuka@gmail.com) to remove the dependency on
// GTMGarbageCollection.h, which is not available on the iPhone.

#import "GTMNSString+URLArguments.h"

@implementation NSString (GTMNSStringURLArgumentsAdditions)

- (NSString*)gtm_stringByEscapingForURLArgument {
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *escaped =
    (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                       (CFStringRef)self,
                                                       NULL,
                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                       kCFStringEncodingUTF8));
    return escaped;
}

- (NSString*)gtm_stringByUnescapingFromURLArgument {
    NSMutableString *resultString = [NSMutableString stringWithString:self];
    [resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, [resultString length])];
    return [resultString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
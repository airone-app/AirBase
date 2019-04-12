//
//  NSObject+JSON.m
//  jiayoubao
//
//  Created by candela on 14-7-8.
//  Copyright (c) 2014年 jtjr99. All rights reserved.
//

#import "NSObject+AirEncode.h"
#import <CommonCrypto/CommonDigest.h>



@implementation NSDictionary (AirEncode)

- (NSString *)air_URLStringAppendParamToURL:(NSString *)URL
{
    NSUInteger paramCount = [self count];
    if (paramCount == 0)
    {
        return URL;
    }
    
    NSMutableString *buff = [[NSMutableString alloc] initWithCapacity:paramCount + 1];
    if (URL != nil)
    {
        [buff appendString:URL];
    }
    
    NSString *endValue = nil;
    NSRange range = [URL rangeOfString:@"#"];
    if (range.location != NSNotFound)
    {
        endValue = [URL substringFromIndex:range.location];
        [buff replaceCharactersInRange:NSMakeRange(range.location, endValue.length) withString:@""];
    }
    
    // 如果没有问号
    if ([buff rangeOfString:@"?"].location == NSNotFound)
    {
        [buff appendString:@"?"];
    }
    else if(![buff hasSuffix:@"&"])
    {
        [buff appendString:@"&"];
    }
    
    NSString *paramString = [self air_encodeParamsString];
    if (paramString.length > 0)
    {
        [buff appendString:paramString];
    }
    
    if (endValue != nil)
    {
        [buff appendString:endValue];
    }
    
    return buff;
}

- (NSString *)air_paramsStringWithEncode:(BOOL)encode {
    NSUInteger paramCount = [self count];
    if (paramCount == 0)
    {
        return @"";
    }
    
    
    NSString *endKey = nil;
    NSString *endValue = nil;
    
    NSMutableString *buff = [[NSMutableString alloc] initWithCapacity:paramCount + 1];
    
    NSArray *keys = [self allKeys];
    for (NSUInteger i = 0; i < keys.count; i++)
    {
        NSString *key = [keys objectAtIndex:i];
        id obj = [self objectForKey:key];
        NSString *value = nil;
        
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            value = [obj air_paramsStringWithEncode:encode];
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            value = [obj componentsJoinedByString:@","];
        }
        else if ([obj isKindOfClass:[NSString class]])
        {
            if (encode) {
                // 新网存管需整体encode
                value = [obj air_URLEncodingUTF8String];
            } else {
                value = obj;
            }
        }
        else
        {
            value = obj;
        }
        
        if (value != nil)
        {
            if ([value rangeOfString:@"#"].location == NSNotFound)
            {
                [buff appendString:key];
                [buff appendString:@"="];
                [buff appendString:value];
                
                if (i != keys.count - 1)
                {
                    [buff appendString:@"&"];
                }
            }
            else
            {
                endKey = key;
                endValue = value;
            }
        }
    }
    
    if (endKey != nil && endValue != nil)
    {
        [buff appendFormat:@"%@=%@", endKey, endValue];
    }
    else if (endValue != nil)
    {
        [buff appendString:endValue];
    }
    
    return buff;
}

- (NSString *)air_paramsString {
    return [self air_paramsStringWithEncode:NO];
}

- (NSString *)air_encodeParamsString {
    return [self air_paramsStringWithEncode:YES];
}


@end




@implementation NSString (AirEncode)


#pragma mark [ md5 ]

- (NSString *)air_md5
{
    const char *ptr = [self UTF8String];
    
    if (self == nil || ptr == nil)
    {
        return nil;
    }
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", md5Buffer[i]];
    }
    
    return output;
}


#pragma mark [ url-encode ]

- (NSString *)air_URLEncodingUTF8String
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             CFSTR("!$&'()*+,-./:;=?@_~%#[]"),    // 指定不转义的字符
                                                                                             NULL,//CFSTR("!*'();:@&=+$,/?%#[]"), // 指定要转义的字符
                                                                                             kCFStringEncodingUTF8));
    // (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]"
    return result;
    
    //    static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    //    static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    //
    //    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    //    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    //
    //    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
}

- (NSString *)air_URLDecodingUTF8String
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    
    //    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault,
    //                                                                                                (CFStringRef)self,
    //                                                                                                CFSTR("")));
    return result;
}

- (NSString *)air_URLParamEncoding
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             CFSTR("."),
                                                                                             CFSTR("!$&'()*+,-/:;=?@_~%#[]"),
                                                                                             kCFStringEncodingUTF8));
    // (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]"
    return result;
}


#pragma mark [ url-params ]

- (NSString *)air_valueOfParam:(NSString *)param
{
    if (param == nil)
    {
        return @"";
    }
    
    NSString *searchStr = [NSString stringWithFormat:@"&%@=", param];
    NSRange range = [self rangeOfString:searchStr options:NSCaseInsensitiveSearch];
    if (range.location == NSNotFound) {
        searchStr = [NSString stringWithFormat:@"?%@=", param];
        range = [self rangeOfString:searchStr options:NSCaseInsensitiveSearch];
    }
    
    if (range.location != NSNotFound)
    {
        range.location += searchStr.length;
        range.length = self.length - range.location;
        
        if (range.location < self.length && range.length > 0)
        {
            NSString *subStr = [self substringWithRange:range];
            
            range = [subStr rangeOfString:@"&" options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound)
            {
                return [subStr substringToIndex:range.location];
            }
            else
            {
                return subStr;
            }
        }
    }
    
    return @"";
}

- (NSString *)air_replaceParamOfKey:(NSString *)param withValue:(NSString *)value
{
    if (param == nil || value == nil)
    {
        return self;
    }
    
    NSString *value1 = [self air_valueOfParam:param];
    
    NSString *subString = [NSString stringWithFormat:@"%@=%@", param, value1];
    NSString *replaceString = [NSString stringWithFormat:@"%@=%@", param, value];
    
    return [self stringByReplacingOccurrencesOfString:subString withString:replaceString];
}

- (NSString *)air_URLParamDecoding
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR("")));
    return result;
}


- (NSDictionary *)air_paramsDictionary
{
    return [self air_paramsDictionaryWithDecode:NO];
}

- (NSDictionary *)air_decodeParamsDictionary
{
    return [self air_paramsDictionaryWithDecode:YES];
}


- (NSDictionary *)air_paramsDictionaryWithDecode:(BOOL)decode
{
    NSString *URLParam = self;
    if ([URLParam hasPrefix:@"&"] || [URLParam hasPrefix:@"?"])
    {
        URLParam = [URLParam substringFromIndex:1];
    }
    else
    {
        NSRange queryRange = [URLParam rangeOfString:@"?"];
        if (queryRange.location != NSNotFound)
        {
            URLParam = [URLParam substringFromIndex:queryRange.location + 1];
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSArray *params = [URLParam componentsSeparatedByString:@"&"];
    for (NSString *param in params)
    {
        NSMutableArray *maps = [[NSMutableArray alloc] initWithCapacity:2];
        NSRange paramRange = [param rangeOfString:@"="];
        if (paramRange.location != NSNotFound)
        {
            NSString *paramKey = [param substringToIndex:paramRange.location];
            if (paramKey == nil)
            {
                paramKey = @"";
            }
            
            NSString *paramValue = [param substringFromIndex:paramRange.location + 1];
            if (paramValue == nil)
            {
                paramValue = @"";
            }
            
            [maps addObject:paramKey];
            [maps addObject:paramValue];
        }
        else
        {
            [maps addObject:param];
        }
        
        NSString *key = nil;
        NSString *value = nil;
        if (maps.count == 2)
        {
            key = [maps objectAtIndex:0];
            value = [maps objectAtIndex:1];
        }
        else if (maps.count > 2)
        {
            NSMutableArray *copyMaps = [maps mutableCopy];
            key = [copyMaps objectAtIndex:0];
            value = [copyMaps objectAtIndex:1];
            
            [copyMaps removeObjectsInRange:NSMakeRange(0, 2)];
            
            for (NSString *copyMap in copyMaps)
            {
                value = [value stringByAppendingFormat:@"=%@", copyMap];
            }
        }
        
        if (key.length > 0 && value.length > 0)
        {
            if (decode)
            {
                NSString *decodeValue = [value air_URLParamDecoding];
                if (decodeValue == nil) {
                    decodeValue = @"";
                }
                [dict setValue:decodeValue forKey:key];
            }
            else
            {
                [dict setValue:value forKey:key];
            }
        }
    }
    
    return dict;
}



- (NSString *)air_appendValue:(NSString *)value param:(NSString *)param
{
    if (value == nil || param == nil)
    {
        return self;
    }
    
    NSString *paramString = [NSString stringWithFormat:@"%@=%@", param, value];
    
    NSRange range = [self rangeOfString:@"#"];
    if (range.location != NSNotFound)
    {
        NSString *replaceString = nil;
        NSString *subString = [self substringFromIndex:range.location];
        NSRange range1 = [self rangeOfString:@"?"];
        if (range1.location != NSNotFound)
        {
            replaceString = [NSString stringWithFormat:@"&%@%@", paramString, subString];
        }
        else
        {
            replaceString = [NSString stringWithFormat:@"?%@%@", paramString, subString];
        }
        
        return  [self stringByReplacingOccurrencesOfString:subString
                                                withString:replaceString];
    }
    else
    {
        NSString *resultURL = nil;
        NSRange range1 = [self rangeOfString:@"?"];
        if (range1.location != NSNotFound)
        {
            resultURL = [self stringByAppendingFormat:@"&%@", paramString];
        }
        else
        {
            resultURL = [self stringByAppendingFormat:@"?%@", paramString];
        }
        
        return resultURL;
    }
}

- (NSString *)air_removeValue:(NSString *)value param:(NSString *)param
{
    if (value == nil || param == nil)
    {
        return self;
    }
    
    NSString *param1 = [NSString stringWithFormat:@"?%@=%@", param, value];
    NSString *param2 = [NSString stringWithFormat:@"&%@=%@", param, value];
    NSString *resultString = [self stringByReplacingOccurrencesOfString:param1 withString:@""];
    
    return [resultString stringByReplacingOccurrencesOfString:param2 withString:@""];
}

- (NSString *)air_removeParam:(NSString *)param
{
    if (param == nil) {
        return self;
    }
    
    NSDictionary *params = [self air_paramsDictionary];
    NSString *value = params[param];
    if (value != nil) {
        return [self air_removeValue:value param:param];
    }
    
    return self;
}

@end


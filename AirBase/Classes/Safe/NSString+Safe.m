//
//  NSString+Safe.m
//  AppBase
//
//  Created by luochenxun on 2018/9/17.
//

#import "NSString+Safe.h"


@implementation NSString (Safe)

+ (void)load
{
    [super load];
    
#ifdef DEBUG
    return; // 调试模块下不使用safe模块，这样可以在测试的过程中发现问题
#endif
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSCFConstantString") swizzleMethod:@selector(substringFromIndex:)
                                                       withMethod:@selector(lsConstant_substringFromIndex:)];
        
        [NSClassFromString(@"NSTaggedPointerString") swizzleMethod:@selector(substringFromIndex:)
                                                        withMethod:@selector(lsPoint_substringFromIndex:)];
        
        [NSClassFromString(@"__NSCFConstantString") swizzleMethod:@selector(substringToIndex:)
                                                       withMethod:@selector(lsConstant_substringToIndex:)];
        
        [NSClassFromString(@"NSTaggedPointerString") swizzleMethod:@selector(substringToIndex:)
                                                        withMethod:@selector(lsPoint_substringToIndex:)];
        
        [NSClassFromString(@"__NSCFConstantString") swizzleMethod:@selector(substringWithRange:)
                                                       withMethod:@selector(lsConstant_substringWithRange:)];
        
        [NSClassFromString(@"NSTaggedPointerString") swizzleMethod:@selector(substringWithRange:)
                                                        withMethod:@selector(lsPoint_substringWithRange:)];
    });
}

- (NSString *)lsConstant_substringFromIndex:(NSUInteger)from
{
    if (from > self.length )
    {
        return nil;
    }
    return [self lsConstant_substringFromIndex:from];
}

- (NSString *)lsPoint_substringFromIndex:(NSUInteger)from
{
    if (from > self.length )
    {
        return nil;
    }
    return [self lsPoint_substringFromIndex:from];
}

- (NSString *)lsConstant_substringToIndex:(NSUInteger)to
{
    if (to > self.length )
    {
        return nil;
    }
    return [self lsConstant_substringToIndex:to];
}

- (NSString *)lsPoint_substringToIndex:(NSUInteger)to
{
    if (to > self.length )
    {
        return nil;
    }
    return [self lsPoint_substringToIndex:to];
}

- (NSString *)lsConstant_substringWithRange:(NSRange)range
{
    if (range.location > self.length)
    {
        return nil;
    }
    
    if (range.length > self.length)
    {
        return nil;
    }
    
    if ((range.location + range.length) > self.length)
    {
        return nil;
    }
    return [self lsConstant_substringWithRange:range];
}

- (NSString *)lsPoint_substringWithRange:(NSRange)range
{
    if (range.location > self.length)
    {
        return nil;
    }
    
    if (range.length > self.length)
    {
        return nil;
    }
    
    if ((range.location + range.length) > self.length)
    {
        return nil;
    }
    return [self lsPoint_substringWithRange:range];
}

@end



@implementation NSMutableString (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSCFString") swizzleMethod:@selector(substringFromIndex:)
                                               withMethod:@selector(ls_substringFromIndex:)];
        
        [NSClassFromString(@"__NSCFString") swizzleMethod:@selector(substringToIndex:)
                                               withMethod:@selector(ls_substringToIndex:)];
        
        [NSClassFromString(@"__NSCFString") swizzleMethod:@selector(substringWithRange:)
                                               withMethod:@selector(ls_substringWithRange:)];
    });
}

- (NSString *)ls_substringFromIndex:(NSUInteger)from
{
    if (from > self.length )
    {
        return nil;
    }
    return [self ls_substringFromIndex:from];
}

- (NSString *)ls_substringToIndex:(NSUInteger)to
{
    if (to > self.length )
    {
        return nil;
    }
    return [self ls_substringToIndex:to];
}

- (NSString *)ls_substringWithRange:(NSRange)range
{
    if (range.location > self.length)
    {
        return nil;
    }
    
    if (range.length > self.length)
    {
        return nil;
    }
    
    if ((range.location + range.length) > self.length)
    {
        return nil;
    }
    return [self ls_substringWithRange:range];
}

@end

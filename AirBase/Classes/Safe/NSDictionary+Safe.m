//
//  NSDictionary+Safe.m
//  AppBase
//
//  Created by luochenxun on 2018/9/17.
//

#import "NSDictionary+Safe.h"


@implementation NSDictionary (Safe)

+ (void)load
{
    [super load];
    
#ifdef DEBUG
    return; // 调试模块下不使用safe模块，这样可以在测试的过程中发现问题
#endif
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSPlaceholderDictionary") swizzleMethod:@selector(initWithObjects:forKeys:count:)
                                                            withMethod:@selector(ls_initWithObjects:forKeys:count:)];
    });
}

- (instancetype)ls_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++)
    {
        id key = keys[i];
        id obj = objects[i];
        if (!key)
        {
            continue;
        }
        if (!obj)
        {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    
    return [self ls_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end


@implementation NSMutableDictionary (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSDictionaryM") swizzleMethod:@selector(setObject:forKey:)
                                                  withMethod:@selector(ls_setObject:forKey:)];
    });
}

- (void)ls_setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (!anObject)
    {
        return;
    }
    if (!aKey)
    {
        return;
    }
    [self ls_setObject:anObject forKey:aKey];
}

@end


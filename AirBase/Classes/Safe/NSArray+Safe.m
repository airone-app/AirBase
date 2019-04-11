//
//  NSArray+Safe.m
//  AppBase
//
//  Created by luochenxun on 2018/9/17.
//

#import "NSArray+Safe.h"
#import "objc/runtime.h"
#import "AirSwzzling.h"


@implementation NSArray (Safe)

+ (void)load
{
    [super load];
    
#ifdef DEBUG
    return; // 调试模块下不使用safe模块，这样可以在测试的过程中发现问题
#endif
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSPlaceholderArray") swizzleMethod:@selector(initWithObjects:count:)
                                                       withMethod:@selector(ls_initWithObjects:count:)];
        
        [NSClassFromString(@"__NSArrayI") swizzleMethod:@selector(objectAtIndex:)
                                             withMethod:@selector(ls_objectAtIndex:)];
        
        [NSClassFromString(@"__NSArrayI") swizzleMethod:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                             withMethod:@selector(ls_objectAtIndexedSubscript:)];
        
        [NSClassFromString(@"__NSArray0") swizzleMethod:@selector(objectAtIndex:)
                                             withMethod:@selector(ls_zeroObjectAtIndex:)];
        
        [NSClassFromString(@"__NSArray0") swizzleMethod:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                             withMethod:@selector(ls_zeroObjectAtIndexedSubscript:)];
        
        [NSClassFromString(@"__NSSingleObjectArrayI") swizzleMethod:@selector(objectAtIndex:)
                                                         withMethod:@selector(ls_singleObjectAtIndex:)];
        
        [NSClassFromString(@"__NSSingleObjectArrayI") swizzleMethod:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                                         withMethod:@selector(ls_singleObjectAtIndexedSubscript:)];
    });
}

- (instancetype)ls_initWithObjects:(id *)objects count:(NSUInteger)cnt
{
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++)
    {
        if (!objects[i])
        {
            break;
        }
        newCnt++;
    }
    
    return [self ls_initWithObjects:objects count:newCnt];
}

- (id)ls_objectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
        return nil;
    }
    return [self ls_objectAtIndex:index];
}

- (id)ls_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= [self count])
    {
        return nil;
    }
    return [self ls_objectAtIndexedSubscript:index];
}

- (id)ls_zeroObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count)
    {
        return nil;
    }
    return [self ls_zeroObjectAtIndex:index];
}

- (id)ls_zeroObjectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= [self count])
    {
        return nil;
    }
    return [self ls_zeroObjectAtIndexedSubscript:index];
}

- (id)ls_singleObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count)
    {
        return nil;
    }
    return [self ls_singleObjectAtIndex:index];
}

- (id)ls_singleObjectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= [self count])
    {
        return nil;
    }
    return [self ls_singleObjectAtIndexedSubscript:index];
}

@end



@implementation NSMutableArray (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(objectAtIndex:)
                                             withMethod:@selector(ls_objectAtIndex:)];
        [NSClassFromString(@"__NSArrayM") swizzleMethod:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                             withMethod:@selector(ls_objectAtIndexedSubscript:)];
        
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(addObject:)
                                             withMethod:@selector(ls_addObject:)];
        
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:)
                                             withMethod:@selector(ls_insertObject:atIndex:)];
        
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(replaceObjectAtIndex:withObject:)
                                             withMethod:@selector(ls_replaceObjectAtIndex:withObject:)];
        
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(removeObjectAtIndex:)
                                             withMethod:@selector(ls_removeObjectAtIndex:)];
        
        
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(removeObjectsInRange:)
                                             withMethod:@selector(ls_removeObjectsInRange:)];
        
    });
}

- (id)ls_objectAtIndex:(NSUInteger)index
{
    if (index >= self.count)
    {
        return nil;
    }
    return [self ls_objectAtIndex:index];
}

- (id)ls_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= self.count)
    {
        return nil;
    }
    return [self ls_objectAtIndexedSubscript:index];
}

- (void)ls_addObject:(id)anObject
{
    if (!anObject)
    {
        return;
    }
    [self ls_addObject:anObject];
}

- (void)ls_removeObjectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
        return;
    }
    
    return [self ls_removeObjectAtIndex:index];
}

- (void)ls_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index >= [self count])
    {
        return;
    }
    
    if (!anObject)
    {
        return;
    }
    
    [self ls_replaceObjectAtIndex:index withObject:anObject];
}

- (void)ls_removeObjectsInRange:(NSRange)range
{
    if (range.location > self.count)
    {
        return;
    }
    
    if (range.length > self.count)
    {
        return;
    }
    
    if ((range.location + range.length) > self.count)
    {
        return;
    }
    
    return [self ls_removeObjectsInRange:range];
}

- (void)ls_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (index > self.count)
    {
        return;
    }
    
    if (!anObject)
    {
        return;
    }
    
    [self ls_insertObject:anObject atIndex:index];
}


#pragma mark -  - (id)objectAtIndexedSubscript:

- (id)emptyArray_objectAtIndexedSubscript:(NSUInteger)index{
    return nil;
}

- (id)arrayI_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self arrayI_objectAtIndex:index];
    }
    return nil;
}

- (id)arrayM_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self arrayM_objectAtIndex:index];
    }
    return nil;
}

- (id)singleObjectArrayI_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self singleObjectArrayI_objectAtIndexedSubscript:index];
    }
    return nil;
}

@end

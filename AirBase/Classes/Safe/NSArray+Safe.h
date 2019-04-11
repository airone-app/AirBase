//
//  NSArray+Safe.h
//  AppBase
//
//  Created by luochenxun on 2018/9/17.
//
//  通过runtime,来防止数组(NSArray, NSMutableArray)引起的崩溃

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (safe)

@end


@interface NSMutableArray (Safe)

@end

NS_ASSUME_NONNULL_END

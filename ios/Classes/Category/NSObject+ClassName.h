//
// NSObject+ClassName.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#if (TARGET_OS_IPHONE)
#import <Foundation/Foundation.h>

/**
 On the iPhone NSObject does not provide the className method.
 */
@interface NSObject (ClassName)
- (NSString *)className;
+ (NSString *)className;
@end
#endif

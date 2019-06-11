//
// AppServiceManager.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>
#import "AppService.h"

@interface AppServiceManager : NSObject

+ (instancetype)sharedManager;

/**
 注册与获取服务
 */
+ (void)registerService:(id<AppService>)service;
+ (id<AppService>)serviceWithName:(NSString *)name;


/**
 调用服务
 */
+ (BOOL)managerResponseToSelector:(SEL)aSelector;
+ (void)managerForwardInvocation:(NSInvocation *)anInvocation;

@end

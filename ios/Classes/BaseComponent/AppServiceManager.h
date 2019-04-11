//
//  AppDelegateManager.h
//  XXXX
//
//  Created by luochenxun on 2017/8/22.
//  Copyright © 2017年 Kacha-Mobile. All rights reserved.
//

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

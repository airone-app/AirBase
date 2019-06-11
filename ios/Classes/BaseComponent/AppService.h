//
// AppService.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#ifndef AppServer_h
#define AppServer_h

typedef NS_ENUM(NSInteger, AppServicePriority)
{
    AppServicePriorityLow = -4,
    AppServicePriorityMediumLow = -2,
    AppServicePriorityDefault = 0,
    AppServicePriorityMediumHight = 2,
    AppServicePriorityHight = 4,
};


@protocol AppService <UIApplicationDelegate>


@required


/** 服务名 */
+ (NSString *)serviceName;


@optional

/**
 设定服务的启动优先级
 @return 优化级 ServicePriority
 */
- (AppServicePriority)servicePriority;

@end


#endif /* AppServer_h */

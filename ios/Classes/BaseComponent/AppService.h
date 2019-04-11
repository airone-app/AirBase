//
//  AppServer.h
//  XXXX
//
//  Created by luochenxun on 2017/8/22.
//  Copyright © 2017年 Kacha-Mobile. All rights reserved.
//

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

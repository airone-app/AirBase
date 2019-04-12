//
//  SystemInfo.h
//  AppBase
//
//  Created by luochenxun on 2018/9/17.
//
//    获取系统相关信息（iOS版本、App版本、是否越狱等）


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface AirSystemInfo : NSObject


// 返回本类提供的所有设备信息
+ (NSDictionary *)deviceInfo;

/**
 获取设备型号，如：iPhone8,2
 */
+ (NSString *)deviceModel;

/**
 获取设备名称，如：iPhone6 Plus
 */
+ (NSString*)deviceName;

/**
 获取设备分辨率, 如：@"480*320"
 */
+ (NSString *)getDeviceDisplayMetrics;

/**
 是否越狱
 
 @return 是否越狱
 */
+ (BOOL)isJailBroken;


/**
 获取设备Mac地址
 
 @return Mac地址
 */
+ (NSString *)getMacAddress;


/**
 获取App名称
 
 @return app名称
 */
+ (NSString *)getApplicationName;


/**
 获取app版本号
 
 @return app版本号
 */
+ (NSString*) getLocalAppVersion;


/**
 获取BundleID
 
 @return bundle ID
 */
+ (NSString*)getBundleID;


/**
 获取设备当前IP
 
 @return  获取设备当前IP
 */
+ (NSString *)getDeviceIPAdress;


/**
 电池电量
 
 @return 电池电量
 */
+ (CGFloat)getBatteryLevel;


/**
 电池状态
 
 @return 电池状态
 */
+ (NSString *) getBatteryState;


/**
 当期设备语言
 
 @return 当前设备语言
 */
+ (NSString *)getDeviceLanguage;

@end

NS_ASSUME_NONNULL_END

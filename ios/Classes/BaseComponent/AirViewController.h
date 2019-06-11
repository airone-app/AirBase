//
// AirViewController.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.


#import <UIKit/UIKit.h>


@interface AirViewController : UIViewController


/**
 name 和 type 唯一决定一个页面。<p>
 name表示一个页面的id，必须唯一。
 当使用路由跳转时，其跳转协议为： protocal://name?type=xx
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
 name 和 type 唯一决定一个页面。<p>
 type用于当一个页面存在业务复用时，标识所属业务。
 当使用路由跳转时，其跳转协议为： protocal://name?type=xx
 */
@property (nonatomic, readonly, copy) NSString *type;

@end


//
// AirNavigationController.h
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UINavigationController (Air)


/**
 当前显示的NavigationController
 
 @return UINavigationController
 */
+ (UINavigationController *)currentNavigationController;


/**
 当前显示的ViewController(包含prsentViewController)
 
 @return UIViewController
 */
+ (UIViewController *)currentViewController;

/**
 当前NavigationController的topViewController(不包含prsentViewController)
 
 @return UIViewController
 */
+ (UIViewController *)currentTopViewController;

@end




@interface AirNavigationController : UINavigationController <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

NS_ASSUME_NONNULL_END

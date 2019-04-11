//
//  AirNavigationController.h
//  AppBase
//
//  Created by luochenxun on 2018/9/17.
//
//  作为整个应用导航的基类，提供方便简洁的导航方法

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

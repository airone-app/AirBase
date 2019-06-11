//
// AirNavigationController.m
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "AirNavigationController.h"


@implementation UINavigationController (Current)

+ (UINavigationController *)currentNavigationController
{
    UINavigationController *nav = nil;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        if ([selectedViewController isKindOfClass:[UINavigationController class]])
        {
            nav = (UINavigationController *)selectedViewController;
        }
    }
    
    if (nav.presentedViewController != nil)
    {
        if ([nav.presentedViewController isKindOfClass:[UINavigationController class]])
        {
            nav = (UINavigationController *)nav.presentedViewController;
        }
    }
    
    return nav;
}

+ (UIViewController *)currentViewController
{
    UINavigationController *nav = nil;
    UIViewController *vc = nil;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIViewController *rootViewController = keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        if ([selectedViewController isKindOfClass:[UINavigationController class]])
        {
            nav = (UINavigationController *)selectedViewController;
        }
    }
    
    if (nav.presentedViewController != nil)
    {
        if ([nav.presentedViewController isKindOfClass:[UINavigationController class]])
        {
            nav = (UINavigationController *)nav.presentedViewController;
        }
        else if ([nav.presentedViewController isKindOfClass:[UIViewController class]])
        {
            vc = nav.presentedViewController;
        }
    }
    
    if (vc == nil)
    {
        vc = nav.topViewController;
    }
    
    return vc;
}

+ (UIViewController *)currentTopViewController {
    UINavigationController *nav = nil;
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIViewController *rootViewController = keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        if ([selectedViewController isKindOfClass:[UINavigationController class]])
        {
            nav = (UINavigationController *)selectedViewController;
        }
    }
    
    return nav.topViewController;;
}


@end




@interface AirNavigationController ()

@end


@implementation AirNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end

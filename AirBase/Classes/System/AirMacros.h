//
//  AirMacros.h
//  Base
//  为编程方便提供的宏
//
//  Created by luochenxun on 2018/9/12.
//

#ifndef AirMacros_h
#define AirMacros_h


#pragma mark - < 常用宏 >


#pragma mark - < 设计模式 >

// 单实例宏
#define FUNC_INTERCAFE_SINGLETON(className) + (className *)sharedInstance;              \
                                            - (instancetype)init UNAVAILABLE_ATTRIBUTE; \
                                            + (instancetype)new UNAVAILABLE_ATTRIBUTE;  \

#define FUNC_IMPLEMENT_SINGLETON(className)     \
    static className *mInstance = nil;          \
    + (className *)sharedInstance               \
    {                                           \
        static dispatch_once_t once;            \
        dispatch_once(&once, ^{                 \
            mInstance = [[self alloc] init];    \
        });                                     \
        return mInstance;                       \
    }


#pragma mark - < UI 操作宏 >

#define CLEAR_VIEWS(view) [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)]



#pragma mark - < 线程操作 >

#define dispatch_main_sync_safe(block)  \
    if ([NSThread isMainThread]) {      \
        block();                        \
    } else {                            \
        dispatch_sync(dispatch_get_main_queue(), block);   \
    }

// 通用weakify&strongify宏，可以提升使用弱引用效率
#define weakify(var) __weak typeof(var) AHKWeak_##var = var;

#define strongify(var)                                  \
    _Pragma("clang diagnostic push")                    \
    _Pragma("clang diagnostic ignored \"-Wshadow\"")    \
    __strong typeof(var) var = AHKWeak_##var;           \
    _Pragma("clang diagnostic pop")


#endif /* AirMacros_h */
























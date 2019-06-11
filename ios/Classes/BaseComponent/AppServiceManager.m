//
// AppServiceManager.m
// airone
//
// Created by luochenxun(luochenxun@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "AppServiceManager.h"
#import <objc/message.h>

@interface AppServiceManager ()

/**
 管理所有App生命周期服务
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, id<AppService>> *services;

@end



@implementation AppServiceManager

+ (instancetype)sharedManager {
    static AppServiceManager *serviceManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        serviceManager = [[AppServiceManager alloc] init];
    });
    return serviceManager;
}


- (instancetype)init {
    if (self = [super init]) {
        _services = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}


#pragma mark - < Message process >

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self managerResponseToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    __block NSMethodSignature *signature = nil;
    [_services enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<AppService> _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:aSelector]) {
            signature = [(id)obj methodSignatureForSelector:aSelector];
            if (signature.methodReturnLength > 0 && strcmp(signature.methodReturnType, @encode(BOOL)) != 0) {
                signature = nil;
            }
            *stop = YES;
        }
    }];
    
    if (signature != nil) {
        return signature;
    }else {
        return [super methodSignatureForSelector:aSelector];
    }
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [self managerForwardInvocation:anInvocation];
}


#pragma mark - < Public >

+ (void)registerService:(id<AppService>)service {
    return [[AppServiceManager sharedManager] registerService:service];
}

+ (id<AppService>)serviceWithName:(NSString *)name {
    return [[AppServiceManager sharedManager] serviceWithName:name];
}

+ (BOOL)managerResponseToSelector:(SEL)aSelector {
    return [[AppServiceManager sharedManager] managerResponseToSelector:aSelector];
}

+ (void)managerForwardInvocation:(NSInvocation *)anInvocation {
    return [[AppServiceManager sharedManager] managerForwardInvocation:anInvocation];
}

#pragma mark - < Private >

- (void)registerService:(id<AppService>)service {
    @synchronized(self) {
        if ( service != nil && [[service class] serviceName] != nil
                            && _services[[[service class] serviceName]] == nil ) {
            _services[[[service class] serviceName]] = service;
        } else {
            NSAssert(NO, @"service name not valid, maybe is nil or is already existed");
        }
    }
}

- (id<AppService>)serviceWithName:(NSString *)name {
    id<AppService> serviceName = nil;
    if (name.length == 0) {
        NSAssert(NO, @"service name not set");
        return nil;
    }
    @synchronized(self) {
        serviceName = _services[name];
    }
    
    return serviceName;
}

- (BOOL)managerResponseToSelector:(SEL)aSelector {
    __block IMP imp = NULL;
    @synchronized(self) {
        [_services enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<AppService> _Nonnull service, BOOL * _Nonnull stop) {
            if ([service respondsToSelector:aSelector]) {
                imp = [(id)service methodForSelector:aSelector];
                NSMethodSignature *signature = [(id)service methodSignatureForSelector:aSelector];
                if (signature.methodReturnLength > 0 && strcmp(signature.methodReturnType, @encode(BOOL)) != 0) {
                    imp = NULL;
                }
                *stop = YES;
            }
        }];
    }
    return imp != NULL && imp != _objc_msgForward;
}


- (NSString *)objcTypesFromSignature:(NSMethodSignature *)signature {
    NSMutableString *types = [NSMutableString stringWithFormat:@"%s", signature.methodReturnType?:"v"];
    for (NSUInteger i = 0; i < signature.numberOfArguments; i ++) {
        [types appendFormat:@"%s", [signature getArgumentTypeAtIndex:i]];
    }
    return [types copy];
}

- (void)managerForwardInvocation:(NSInvocation *)anInvocation {
    
    NSMethodSignature *signature = anInvocation.methodSignature;
    NSUInteger argCount = signature.numberOfArguments;
    __block BOOL returnValue = NO;
    NSUInteger returnLength = signature.methodReturnLength;
    void * returnValueBytes = NULL;
    if (returnLength > 0) {
        returnValueBytes = alloca(returnLength);
    }
    
    
    NSMutableArray *matchServices = [NSMutableArray arrayWithCapacity:5];
    [_services enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ( [obj respondsToSelector:anInvocation.selector]) {
            [matchServices addObject:obj];
        }
    }];
    [matchServices sortUsingComparator:^NSComparisonResult(id<AppService> obj1, id<AppService> obj2) {
        if ([obj1 respondsToSelector:@selector(servicePriority)] && [obj2 respondsToSelector:@selector(servicePriority)]) {
            return (obj1.servicePriority > obj2.servicePriority)? -1: 1;
        }
        else if ([obj1 respondsToSelector:@selector(servicePriority)] && [obj2 respondsToSelector:@selector(servicePriority)]) {
            return (obj1.servicePriority > 0)? -1: 1;
        }
        else {
            return 1;
        }
    }];
    
    [matchServices enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)  {
        if ( ![obj respondsToSelector:anInvocation.selector]) {
            return;
        }
        
        // check the signature
        NSAssert([[self objcTypesFromSignature:signature] isEqualToString:[self objcTypesFromSignature:[(id)obj methodSignatureForSelector:anInvocation.selector]]],
                 @"Method signature for selector (%@) on (%@ - `%@`) is invalid. \
                 Please check the return value type and arguments type.",
                 NSStringFromSelector(anInvocation.selector), [[obj class] serviceName], obj);
        
        // copy the invokation
        NSInvocation *invok = [NSInvocation invocationWithMethodSignature:signature];
        invok.selector = anInvocation.selector;
        
        // copy arguments
        for (NSUInteger i = 0; i < argCount; i ++) {
            const char * argType = [signature getArgumentTypeAtIndex:i];
            NSUInteger argSize = 0;
            NSGetSizeAndAlignment(argType, &argSize, NULL);
            
            void * argValue = alloca(argSize);
            [anInvocation getArgument:&argValue atIndex:i];
            [invok setArgument:&argValue atIndex:i];
        }
        
        // reset the target
        invok.target = obj;
        
        // invoke
        [invok invoke];
        
        // get the return value
        if (returnValueBytes) {
            [invok getReturnValue:returnValueBytes];
            returnValue = returnValue || *((BOOL *)returnValueBytes);
        }
    }];
    
    // set return value
    if (returnValueBytes) {
        [anInvocation setReturnValue:returnValueBytes];
    }
}

@end

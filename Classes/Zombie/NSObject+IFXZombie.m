//
//  NSObject+IFXZombie.m
//  IFXFoundation
//
//  Created by luckyvon on 2020/6/23.
//

#import "NSObject+IFXZombie.h"
#import <objc/runtime.h>

@implementation IFXZombie

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSLog(@"僵尸对象： %p 调用了方法：%@",self, NSStringFromSelector(sel));
    return [[NSObject new] methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:[NSObject new]];
}

@end

@implementation NSObject (IFXZombie)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        //替换方法
        SEL originalSelector = NSSelectorFromString(@"dealloc");
        SEL swizzledSelector = NSSelectorFromString(@"newDealloc");
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzleMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMehod = class_addMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        
        if (didAddMehod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzleMethod);
        }
    });
}

- (void)newDealloc {
    [self newDealloc];
    //重新设置类
    object_setClass(self, [IFXZombie class]);
}

@end

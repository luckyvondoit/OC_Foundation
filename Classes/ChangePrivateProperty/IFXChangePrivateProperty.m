//
//  IFXChangePrivateProperty.m
//  IFXFoundation
//
//  Created by luckyvon on 2020/7/5.
//

#import "IFXChangePrivateProperty.h"

#import <objc/runtime.h>

#import <objc/message.h>

@interface IFXPrivatePropertyClass ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

@implementation IFXPrivatePropertyClass

- (void)showPrivateVar {
    NSLog(@"name = %@, age = %@",_name,@(_age));
}

@end

@implementation IFXChangePrivateProperty

+ (void)testWay1 {
    IFXPrivatePropertyClass *class = [[IFXPrivatePropertyClass alloc] init];
    [class setValue:@"IFX" forKey:@"_name"];
    [class setValue:@(18) forKey:@"_age"];
    [class showPrivateVar];
}
+ (void)testWay2 {
    IFXPrivatePropertyClass *class = [[IFXPrivatePropertyClass alloc] init];
    
//    unsigned int outCount = 0;
//    Ivar *ivars = class_copyIvarList([IFXPrivatePropertyClass class], &outCount);
//
//    for (int i = 0; i < outCount; i++) {
//        Ivar ivar = ivars[i];
//        const char *ivarName = ivar_getName(ivar);
//
//        //这里要注意ARC下， 这个会报错
//        /**
//         在修改NSInteger型变量的时候，ARC下，编译器不允许你将NSInteger类型的值赋值给id，在buildsetting中将Objective-C Automatic Reference Counting修改为No即可。但是这样工程就会变成MRC，所以，如果是非对象类型就不建议用object_setIvar这样的方法去修改了。
//         */
//
//        int a = strcmp(ivarName, "_age");
//        if (strcmp(ivarName, "_age") == 0) {
//            //这种方式传值int类型会报错，不能传入
//            object_setIvar(class, ivar, 22);
//        }
//
//        if (strcmp(ivarName, "_name") == 0) {
//            object_setIvar(class, ivar, @"IFXName");
//        }
//    }
    
    Ivar nameIvar = class_getInstanceVariable([IFXPrivatePropertyClass class], "_name");
    Ivar ageIvar = class_getInstanceVariable([IFXPrivatePropertyClass class], "_age");
    //为成员变量赋值
    object_setIvar(class, nameIvar, @"张三");
    object_setIvar(class, ageIvar, @23);
    //获取成员变量的值
    NSLog(@"%@",object_getIvar(class, nameIvar));
    NSLog(@"%@",object_getIvar(class, ageIvar));
    
#warning 为啥这个打印age值不对。。。
    [class showPrivateVar];

}
+ (void)testWay3 {
    IFXPrivatePropertyClass *classA = [[IFXPrivatePropertyClass alloc] init];
    ((void (*)(id, SEL, int))(void *)objc_msgSend)((id)classA, @selector(setAge:) , 20);
    ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)classA, @selector(setName:) , @"IFXName1");
    [classA showPrivateVar];
}


@end



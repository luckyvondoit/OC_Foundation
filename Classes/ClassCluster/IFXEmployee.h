//
//  IFXEmployee.h
//  IFXProgram
//
//  Created by luckyvon on 2020/7/7.
//  Copyright © 2020 luckyvon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IFXEmployeeType) {
    IFXEmployeeTypeDeveloper,
    IFXEmployeeTypeDesigner,
    IFXEmployeeTypeFinance
};

@interface IFXEmployee : NSObject

@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSUInteger salary;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (IFXEmployee *)employeeWithType:(IFXEmployeeType)type;
- (void)work;


@end

NS_ASSUME_NONNULL_END

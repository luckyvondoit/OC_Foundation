//
//  IFXEmployee.m
//  IFXProgram
//
//  Created by luckyvon on 2020/7/7.
//  Copyright © 2020 luckyvon. All rights reserved.
//

#import "IFXEmployee.h"
#import "IFXEmployeeDeveloper.h"
#import "IFXEmployeeDesigner.h"
#import "IFXEmployeeFinance.h"


@implementation IFXEmployee

+ (IFXEmployee *)employeeWithType:(IFXEmployeeType)type {
    switch (type) {
        case IFXEmployeeTypeDeveloper:
            return [IFXEmployeeDeveloper new];
            break;
        case IFXEmployeeTypeDesigner:
            return [IFXEmployeeDesigner new];
            break;
        case IFXEmployeeTypeFinance:
            return [IFXEmployeeFinance new];
            break;
    }
}

- (void)work {
    NSLog(@"%@ work",NSStringFromClass([self class]));
}

@end

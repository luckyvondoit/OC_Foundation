//
//  IFXChangePrivateProperty.h
//  IFXFoundation
//
//  Created by luckyvon on 2020/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFXPrivatePropertyClass : NSObject

- (void)showPrivateVar;

@end

@interface IFXChangePrivateProperty : NSObject

+ (void)testWay1;
+ (void)testWay2;
+ (void)testWay3;

@end




NS_ASSUME_NONNULL_END

//
//  IFXFilter.h
//  IFXFoundation
//
//  Created by luckyvon on 2020/6/15.
//  DOC : https://github.com/luckyvondoit/OC_Document/blob/master/Concept/Foundation/Filter.md
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFXFilterPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithName:(NSString *)name age:(NSInteger)age;

@end

@interface IFXFilter : NSObject

+ (NSArray *)presonArray;
+ (NSArray *)randomPersonArray;

@end

@interface IFXFilter (NSPredicate)

+ (void)filterPerson;
+ (BOOL)checkPhoneNum:(NSString *)phoneNum;
+ (void)filterArray;
+ (void)filterPersonInArray;
+ (void)placeholderCharacter;


@end

@interface IFXFilter (NSSortDescriptor)

+ (void)sortSingle;
+ (void)sortCombination;

@end

@interface IFXFilter (KVC)

+ (void)filterWithKVC;

@end

NS_ASSUME_NONNULL_END

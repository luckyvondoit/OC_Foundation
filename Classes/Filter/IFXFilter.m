//
//  IFXFilter.m
//  IFXFoundation
//
//  Created by luckyvon on 2020/6/15.
//

#import "IFXFilter.h"

@implementation IFXFilterPerson

+ (instancetype)personWithName:(NSString *)name age:(NSInteger)age {
    IFXFilterPerson *person = [IFXFilterPerson new];
    person.name = name;
    person.age = age;
    return person;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[name = %@, age = %@]", self.name, @(self.age)];
}

@end

@implementation IFXFilter

+ (NSArray *)presonArray {
    NSArray *array = @[[IFXFilterPerson personWithName:@"张三" age:12],
    [IFXFilterPerson personWithName:@"张云" age:24],
    [IFXFilterPerson personWithName:@"李四" age:25]];
    return array;
}

+ (NSArray *)randomPersonArray {
    NSMutableArray *personArray= [NSMutableArray arrayWithCapacity:10];
        
    for (NSInteger i = 0; i < 10; i++) {
        NSInteger age = arc4random()%100;
        NSString *name = [NSString stringWithFormat:@"张%@",@(age)];
        
        IFXFilterPerson *person = [IFXFilterPerson personWithName:name age:age];
        [personArray addObject:person];
    }
    return [personArray copy];
}

@end

@implementation IFXFilter (NSPredicate)

+ (void)filterPerson {
    IFXFilterPerson *person = [IFXFilterPerson personWithName:@"张三" age:20];
     //1.判断姓名是否以“张”开头
     NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name like '张*'"];//name必须是模型中已存在的属性
     BOOL result1 = [predicate1 evaluateWithObject:person];
    NSLog(@"result1 is %@",@(result1));//result1 is YES
     
     //2.判断年龄是否大于25
     NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"age > 25"]; //age必须是模型中已存在的属性
     BOOL result2 = [predicate2 evaluateWithObject:person];
     NSLog(@"result2 is %@",@(result2));//result2 is NO
}

+ (BOOL)checkPhoneNum:(NSString *)phoneNum {
    NSString *regex = @"^[1][3-8]\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneNum];
}

+ (void)filterArray {
    NSMutableArray *arrayM = [@[@20, @40, @50, @30, @60, @70] mutableCopy];
    //  过滤大于50的值
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF > 50"];
    //该方法只有可变数组才有，不可变数组没有此方法
    [arrayM filterUsingPredicate:pred1];
    
    NSLog(@"%@",arrayM);
}

+ (void)filterPersonInArray {
    NSArray *array = [self presonArray];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains '张'"];
    NSArray *resultArray = [array filteredArrayUsingPredicate:predicate];
    NSLog(@"resultArray is %@",resultArray);//resultArray is "[name = 张三, age = 12], [name = 张云, age = 24]"
}

+ (void)placeholderCharacter {
    NSArray *array = [self presonArray];

    NSString *property = @"name";
    NSString *value = @"张";
    //1.筛选出名字中包含"张"的;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K contains %@", property, value];
    NSArray *resultArray = [array filteredArrayUsingPredicate:predicate];
    NSLog(@"resultArray is %@",resultArray);//resultArray is "[name = 张三, age = 12], [name = 张云, age = 24]"
    
    //2.筛选出年龄大于24的;
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"%K > $Value", @"age"];
    //必须加上下面这句，不然会报错。$Value(Value可以随便改，统一就行)个人感觉是声明一个变量，下面是给变量赋值。
    predicate2 = [predicate2 predicateWithSubstitutionVariables:@{@"Value":@24}];
    NSArray *resultArray2 = [array filteredArrayUsingPredicate:predicate2];
    NSLog(@"resultArray2 is %@",resultArray2);//resultArray2 is "[name = 李四, age = 25]"
}

@end

@implementation IFXFilter (NSSortDescriptor)

+ (void)sortSingle {
     // 按照 age 进行排序
    // key --> 指定排序规则，ascending --> YES：升序   NO：降序
    
    NSMutableArray *personArray = [NSMutableArray arrayWithArray:[self randomPersonArray]];
    
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
    [personArray sortUsingDescriptors:@[sd]];
    
    NSLog(@"%@",personArray);
        
}

+ (void)sortCombination {
      // 先按照 stu_name 进行排序，当 stu_name 一致时，再按照 stu_age 进行排序
    
    NSMutableArray *personArray = [NSMutableArray arrayWithArray:[self randomPersonArray]];
    
    NSSortDescriptor *sd_name = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *sd_age  = [[NSSortDescriptor alloc] initWithKey:@"age"  ascending:YES];
    
    [personArray sortUsingDescriptors:@[sd_name, sd_age]];
    
    NSLog(@"%@",personArray);
        
}

@end

@implementation IFXFilter (KVC)

+ (void)filterWithKVC {
    NSArray *personArray = [self randomPersonArray];
    
    NSInteger min = [[personArray valueForKeyPath:@"@min.age"] integerValue];
    NSInteger max = [[personArray valueForKeyPath:@"@max.age"] integerValue] ;
    NSInteger sum =[[personArray valueForKeyPath:@"@sum.age"] integerValue];
    double avg = [[personArray valueForKeyPath:@"@avg.age"] doubleValue] ;
    
    NSLog(@"age min = %@, max = %@, sum = %@, avg = %@",@(min), @(max), @(sum), @(avg));
}

@end

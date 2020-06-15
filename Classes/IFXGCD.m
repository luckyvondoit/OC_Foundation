//
//  IFXGCD.m
//  IFXFramework
//
//  Created by luckyvon on 2020/5/2.
//  Copyright © 2020 luckyvon. All rights reserved.
//

#import "IFXGCD.h"

@implementation IFXGCD

+ (void)test {
    dispatch_queue_t queue =  dispatch_queue_create_with_target("com.ifx", DISPATCH_QUEUE_CONCURRENT,dispatch_get_main_queue());
    dispatch_async(queue, ^{
        NSLog(@"1 %@ %@",[NSThread currentThread],queue);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2 %@ %@",[NSThread currentThread],queue);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3 %@ %@",[NSThread currentThread],queue);
    });
    
    Block_release();

}

@end

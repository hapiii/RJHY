//
//  HYBaseUtil.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseUtil.h"

@implementation HYBaseUtil

-(void)doSomeThing:(dispatch_block_t)action{
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // 可以用该语句查看当前线程
    NSLog(@"当前线程--%@", [NSThread currentThread]);
    
    // 此处需要写一个异步任务，是因为需要开辟一个新的线程去反复执行你的代码块，否则会阻塞主线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        while (TRUE) {
            
            // 每隔5秒执行一次（当前线程阻塞5秒）
            [NSThread sleepForTimeInterval:5];
            
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
            

            action();
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        };
    });
    
  
}
@end

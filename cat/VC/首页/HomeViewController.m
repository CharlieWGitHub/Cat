//
//  HomeViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/7.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "HomeViewController.h"
#import "SafeInspactionClasss.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    [self method];
    
    [self hashMethod];
}

//GCD 信号量的使用
/**
这个方法会使信号量加一
 dispatch_semaphore_signal
这个方法会使信号量减一
 dispatch_semaphore_wait
 当信号量是0时候 第二个方法会阻塞，不会向下执行，知道信号量不为0
 
 */
- (void)method{

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"完成任务——%d",i);
//              延迟 4 秒
                sleep(4);
                dispatch_semaphore_signal(semaphore);
                NSLog(@"当前线程：%@",[NSThread currentThread]);
            });
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        NSLog(@"任务全部执行完成");
    });
}

- (void)hashMethod{
    
    NSString * string = @"123456789abcdefghijklmnopqrstuvwxyz";
    
    
    
}


@end

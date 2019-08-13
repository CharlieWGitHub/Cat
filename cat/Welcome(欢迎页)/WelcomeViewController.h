//
//  WelcomeViewController.h
//  cat
//
//  Created by 王成龙 on 2019/8/8.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *CatWelcomeIsLaunchDefaultKey = @"isLaunch";

@interface WelcomeViewController : UIViewController

/// 翻页小圆点, 可自行设置它的参数
@property (nonatomic, weak)UIPageControl *pageControl;
/// "立即体验"按钮, 可自行设置位置及样式参数, 默认是"立即体验"
@property (nonatomic, weak)UIButton *showRootControllerBtn;
/**
 初始化方法
 
 @param imageArr 图片名称的字符串数组
 @param rootVC 点击"立即体验"后跳转的控制器
 @return 欢迎页控制器
 */
- (WelcomeViewController *)initWithImageNameArray:(NSArray *)imageArr rootViewController:(UIViewController *)rootVC;


@end

NS_ASSUME_NONNULL_END

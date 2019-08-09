//
//  BaseViewController.h
//  cat
//
//  Created by 王成龙 on 2019/8/9.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

//返回按钮
@property(nonatomic,strong) UIButton * backButton;
//导航栏标题
@property(nonatomic,strong) UILabel * navigationTitleLabel;
//导航栏右按钮（图片）
@property(nonatomic,strong) UIButton * rightButton;
//导航栏右按钮（文字）
@property(nonatomic,strong) UIButton * rightTextButton;

//为了灵活的满足不同的ViewController，将set方法放到.h文件，供子类调用
-(void)setupNavigationItem;
-(void)setBackButton;
-(void)setRightButton;
-(void)setNavigationTitleLabel;
-(void)setRightTextButton;

//返回按钮和右按钮点击方法，如果需要实现不同的方法，子类可以重新该方法
-(void)navBackClick;
-(void)navRightClick;
-(void)navRightTextClick;







@end

NS_ASSUME_NONNULL_END

//
//  WelcomeViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/8.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *imageArr;
@property (nonatomic, strong)UIViewController *rootVC;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (WelcomeViewController *)initWithImageNameArray:(NSArray *)imageArr rootViewController:(UIViewController *)rootVC{
    if (self = [super init]) {
        _imageArr = imageArr;
        _rootVC = rootVC;
        [self setupSubviewsWithImageArr:imageArr];
    }
    return self;
}
- (void)setupSubviewsWithImageArr:(NSArray *)imageArr{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = CGSizeMake(imageArr.count * CGRectGetWidth(self.view.frame), 0);
    scrollView.bounces = YES;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArr[i]]];
        imageView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        if (i == imageArr.count - 2) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.layer.borderWidth = 2;
            button.layer.borderColor = [UIColor darkGrayColor].CGColor;
            button.layer.cornerRadius = 4;
            CGFloat buttonWidth = 100;
            button.frame = CGRectMake((CGRectGetWidth(self.view.frame) - buttonWidth)/2, CGRectGetHeight(self.view.frame) * 0.89, buttonWidth, 30);
            [button addTarget:self action:@selector(showRootControllerButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(self.view).offset(-40);
//                make.centerX.equalTo(self.view);
//                make.size.mas_equalTo(CGSizeMake(120, 35));
//            }];
            
            self.showRootControllerBtn = button;
            
            
        }
    }
//   小点点
//    CGRect rect = CGRectMake(0, CGRectGetHeight(self.view.frame) * 0.8, CGRectGetWidth(self.view.frame), 15);
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:rect];
//    pageControl.numberOfPages = imageArr.count;
//    pageControl.hidesForSinglePage = YES;
//    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
//    [self.view addSubview:pageControl];
//    self.pageControl = pageControl;
}

//  点击"立即体验"
- (void)showRootControllerButtonClick{
    // 再次使用app时, 不再出现欢迎页
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setBool:YES forKey:CatWelcomeIsLaunchDefaultKey];
//    [userDefault synchronize];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = self.rootVC;
    CATransition *anim = [CATransition animation];
    anim.type = kCATransitionFade;
    anim.duration = 0.4;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat page = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
//    NSLog(@"page===%f",page);
    if (page > 2.2) {
        [self showRootControllerButtonClick];
    }
    
//    self.pageControl.currentPage = roundf(page);// 四舍五入
//    if (page > (self.pageControl.numberOfPages - 1.5)) {
////        self.pageControl.alpha = 0;
////        self.pageControl.hidden = YES;
////        self.showRootControllerBtn.hidden = YES;
//    }else{
//        [UIView animateWithDuration:0.3 animations:^{
////            self.pageControl.alpha = 1;
//        } completion:^(BOOL finished) {
////            self.pageControl.hidden = NO;
////            self.showRootControllerBtn.hidden = NO;
//        }];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

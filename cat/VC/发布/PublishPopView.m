//
//  PublishPopView.m
//  cat
//
//  Created by 王成龙 on 2019/8/9.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "PublishPopView.h"
#import "TabbarItemButton.h"

static NSInteger const kColumnCount = 3;
static NSTimeInterval kAnimationDuration = 0.3;

@interface PublishPopView () <UIScrollViewDelegate>

@property (nonatomic,   copy) NSArray *imageNames;
@property (nonatomic,   copy) NSArray *titles;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic,   copy) void (^selectBlock)(NSInteger index);
@property (nonatomic, strong) UIImageView *shutImgView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIImageView *headImgView;

@end

@implementation PublishPopView
+ (void)showWithImages:(NSArray *)imgs titles:(NSArray *)titles selectBlock:(void (^)(NSInteger))selectBlock {
   
    PublishPopView *bg = [[PublishPopView alloc] initWithFrame:CGRectMake(0, 0, lSCREEN_WIDTH, lSCREEN_HEIGHT - kDefectHeight)];
    bg.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:bg];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = bg.bounds;
    //     effectView.alpha = 0.8;
    [bg addSubview:effectView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:bg action:@selector(close)];
    [bg addGestureRecognizer:tap];
    bg.imageNames = imgs.copy;
    bg.titles = titles.copy;
    bg.selectBlock = [selectBlock copy];
    [bg setupHeadImage];
    [bg setupMainView];
    [bg setupItem];
    [bg setupBottom];
}
- (void)setupHeadImage{
    self.headImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"compose_slogan"]];    
    self.headImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.headImgView];
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(64);
        make.size.mas_equalTo(CGSizeMake(308, 96));
    }];
}
- (void)setupMainView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.37, self.frame.size.width, 300)];
    scrollView.delegate = self;
    NSInteger pages = (self.titles.count - 1) / (kColumnCount * 2) + 1;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * pages, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(self.frame.size.width / 2 - 10, self.bounds.size.height - 49 - 20 - 20, 20, 20);//指定位置大小
    pageControl.numberOfPages = pages;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor =  HEXColor(@"#c0c0c0");
    pageControl.currentPageIndicatorTintColor = HEXColor(@"#1fb497");
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

- (void)setupItem {
    CGFloat vMargin = 15;
    CGFloat vSpacing = 20;
    CGFloat itemWidth = self.scrollView.frame.size.width / kColumnCount;
    CGFloat itemHeight = (265 - 2 * vMargin - vSpacing) * 0.5;
    NSInteger row = 0;
    NSInteger loc = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i < self.imageNames.count; i ++) {
        row = i / kColumnCount % 2; // % 2  为了翻页
        loc = i % kColumnCount ;
        x = itemWidth * loc + (i / (kColumnCount * 2)) * self.scrollView.frame.size.width;
        if (i / (kColumnCount * 2) > 0) {
            y = vMargin + (itemWidth + vSpacing) * row;
        } else {
            y = self.scrollView.frame.size.height + (itemHeight + vSpacing) * row;
        }
        TabbarItemButton *button = [[TabbarItemButton alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        button.tag = 1000 + i;
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:HEXColor(@"#666666") forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setImage:[UIImage imageNamed:self.imageNames[i]] forState:UIControlStateNormal];
        [button.imageView setContentMode:UIViewContentModeCenter];
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
        if (i < kColumnCount * 2) {
            [UIView animateWithDuration:kAnimationDuration
                                  delay:i * 0.06
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:0.04
                                options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                    button.frame  = CGRectMake(itemWidth * loc, vMargin + (itemHeight + vSpacing) * row, itemWidth, itemHeight);
                                } completion:^(BOOL finished) {
                                }];
        }
    }
}

- (void)setupBottom {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 49, self.bounds.size.width, 49)];
    [self addSubview:bottomView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomView.bounds.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:line];
    
    UIImageView *shutImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    self.shutImgView = shutImgView;
    shutImgView.image = [UIImage imageNamed:@"icon_add_1_n"];
    shutImgView.center = CGPointMake(bottomView.bounds.size.width * 0.5, bottomView.bounds.size.height * 0.5);
    [bottomView addSubview:shutImgView];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.shutImgView.transform = CGAffineTransformMakeRotation(M_PI_4);
    }];
}

#pragma mark - event response
- (void)selectClick:(TabbarItemButton *)button {
   
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        [self removeFromSuperview];

    } completion:^(BOOL finished) {
  
    }];
   
    if (self.selectBlock) {
        self.selectBlock(button.tag - 1000);
    }
}

- (void)close {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.shutImgView.transform = CGAffineTransformMakeRotation(0);
    }];
    self.pageControl.hidden = YES;
    
    CGFloat dy = CGRectGetHeight(self.frame) + 70;
    NSInteger count = 0;
    if (self.imageNames.count / (kColumnCount * 2) > self.currentPage) {
        count = kColumnCount * 2; // 当前要具有 kColumnCount * 2个按钮;
    } else {
        count = self.imageNames.count % (kColumnCount * 2); // 最后一页
    }
    
    for (int i = 0; i < count; i ++) {
        TabbarItemButton *button = [self viewWithTag:1000 + self.currentPage * (kColumnCount * 2)  + i];
        CGFloat width = CGRectGetWidth(button.frame);
        CGFloat buttonX = button.frame.origin.x;//0.3-i*0.03
        [UIView animateWithDuration:kAnimationDuration
                              delay:0.03 * count - i * 0.03
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.04
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                button.frame  = CGRectMake(buttonX, dy, width, width);
                            } completion:^(BOOL finished) {
                                [self removeFromSuperview];
                            }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.currentPage = page;
    // 设置页码
    self.pageControl.currentPage = page;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

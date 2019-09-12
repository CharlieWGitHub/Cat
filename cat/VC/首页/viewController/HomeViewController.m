//
//  HomeViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/7.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "HomeViewController.h"
#import "ItemSelectView.h"
#import "RecommendViewController.h"
#import "HotViewController.h"
#import "FollowViewController.h"

@interface HomeViewController ()<ItemSelectDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)ItemSelectView * selectView;
@property (nonatomic,strong)UIScrollView * homeScrollView;
@property (nonatomic,strong)RecommendViewController * recommendVC;
@property (nonatomic,strong)HotViewController * hotVC;
@property (nonatomic,strong)FollowViewController *followVC;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    [self creatUI];
    
}

#pragma mark UI
- (void)creatUI{
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.homeScrollView];
}

#pragma mark Delegate
- (void)selectedItemIndex:(NSInteger)index{
    CCLog(@"选择：%ld",(long)index);
    [UIView animateWithDuration:0.3 animations:^{
        self.homeScrollView.contentOffset = CGPointMake(lSCREEN_WIDTH*(index-1), 0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    double index = scrollView.contentOffset.x/lSCREEN_WIDTH;
//    CCLog(@"滚动==%f",index);
//    [self.selectView updateItemSelectedIndex:index];
//    [self sliderAnimationWithTag:(int)(index_+0.5)];
}

//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView{
    
}
//停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate{
    double index = scrollView.contentOffset.x/lSCREEN_WIDTH;
    if (index<0.5) {
        [self.selectView updateItemSelectedIndex:0];
    }else if (index<1.5 && index > 0.5){
        [self.selectView updateItemSelectedIndex:1];
    }else if (index>1.5){
        [self.selectView updateItemSelectedIndex:2];
    }
}
// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
-(void)scrollViewWillBeginDecelerating:(UIScrollView*)scrollView{
}
// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView{

}
#pragma mark private

#pragma mark set get
-(ItemSelectView *)selectView{
    if (!_selectView) {
        _selectView = [[ItemSelectView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, lSCREEN_WIDTH,kWidth(80))];
        _selectView.delegate = self;
    }
    return _selectView;
}

-(UIScrollView *)homeScrollView{
    if (!_homeScrollView) {
        _homeScrollView = [[UIScrollView alloc]init];
        _homeScrollView.frame = CGRectMake(0, STATUS_BAR_HEIGHT+kWidth(80), lSCREEN_WIDTH, lSCREEN_HEIGHT -STATUS_BAR_HEIGHT -kWidth(80)-TABBAR_HEIGHT);
        _homeScrollView.delegate = self;
        _homeScrollView.pagingEnabled = YES;
        _homeScrollView.showsHorizontalScrollIndicator = NO;
        _homeScrollView.showsVerticalScrollIndicator = NO;
//      _homeScrollView.
        NSArray *views = @[self.recommendVC.view,self.hotVC.view,self.followVC.view];
        for (NSInteger i = 0; i<views.count; i++) {
            //把三个vc的view依次贴到_mainScrollView上面
            UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(lSCREEN_WIDTH*i, 0, lSCREEN_WIDTH, self.homeScrollView.frame.size.height)];
            [pageView addSubview:views[i]];
            [_homeScrollView addSubview:pageView];
        }
        _homeScrollView.contentSize = CGSizeMake(lSCREEN_WIDTH*views.count, 0);

    }
    return _homeScrollView;
}
- (RecommendViewController *)recommendVC{
    if (!_recommendVC) {
        _recommendVC = [[RecommendViewController alloc]init];
    }
    return _recommendVC;
}
- (HotViewController *)hotVC{
    if (!_hotVC) {
        _hotVC = [[HotViewController alloc]init];
    }
    return _hotVC;
}
-(FollowViewController *)followVC{
    if (!_followVC) {
        _followVC = [[FollowViewController alloc]init];
    }
    return _followVC;
}
@end

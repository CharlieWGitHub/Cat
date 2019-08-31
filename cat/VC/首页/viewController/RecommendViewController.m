//
//  RecommendViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/29.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "RecommendViewController.h"
#import "HW3DBannerView.h"
#import "MessageCell.h"

@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * recommendTable;
@property (nonatomic,strong) HW3DBannerView * bannerHeadView;


@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.bannerHeadView.data = @[@"https://hbimg.huabanimg.com/d7518ec1737c70fbfae3b0cca4fdacd86c8a684c8936-r3tTQY_fw658",@"https://img.zcool.cn/community/0142df5d65fdaca8012187f4fd5f7c.jpg@1280w_1l_2o_100sh.jpg"
                                ,@"https://img.zcool.cn/community/0142df5d65fdaca8012187f4fd5f7c.jpg@1280w_1l_2o_100sh.jpg" ,@"https://hbimg.huabanimg.com/af58b93cc32831779e749118def7010561158da715db0-NjZkD7_fw658"];
    self.bannerHeadView.clickImageBlock = ^(NSInteger currentIndex) {
        CCLog(@"current==%ld",(long)currentIndex);
    };
    [self.view addSubview:self.recommendTable];
    
 
 
    
    // Do any additional setup after loading the view.
}


#pragma mark delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row ==0) {
        MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"messagecell"];
        if (!cell) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messagecell"];
        }
        return cell;
    }else{
      
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"testdata - %zd", indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return  kWidth(140);
    }else
        return kWidth(44);
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableView *)recommendTable{
    if (!_recommendTable) {
        _recommendTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _recommendTable.delegate = self;
        _recommendTable.dataSource = self;
        _recommendTable.tableHeaderView = self.bannerHeadView;
    }
    return _recommendTable;
}

-(HW3DBannerView *)bannerHeadView{
    if (!_bannerHeadView) {
        _bannerHeadView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, lSCREEN_WIDTH, 150) imageSpacing:10 imageWidth:lSCREEN_WIDTH-50];
        _bannerHeadView.initAlpha = 0.5;// 设置两边卡片的透明度
        _bannerHeadView.imageRadius = 10.f;// 设置卡片圆角
        _bannerHeadView.imageHeightPoor = 10.f;// 设置中间卡片与两边卡片的高度差
        
    }
    return _bannerHeadView;
}


@end

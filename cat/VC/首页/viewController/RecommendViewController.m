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
    self.bannerHeadView.data = @[@"https://hbimg.huabanimg.com/1b74928054dc558ccec099adfa9e4b5b936f427f111f5-aPZDUW_fw658",@"https://hbimg.huabanimg.com/d7518ec1737c70fbfae3b0cca4fdacd86c8a684c8936-r3tTQY_fw658",@"https://hbimg.huabanimg.com/e35e196318713858f889d4aca4d36490797b6b6c2b85d-j91MKb_fw658",@"https://hbimg.huabanimg.com/af58b93cc32831779e749118def7010561158da715db0-NjZkD7_fw658"];
    self.bannerHeadView.clickImageBlock = ^(NSInteger currentIndex) {
        
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
        
    // 0.重用标识
    // 被static修饰的局部变量：只会初始化一次，在整个程序运行过程中，只有一份内存
        static NSString *ID = @"cell";
    // 1.先根据cell的标识去缓存池中查找可循环利用的cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果cell为nil（缓存池找不到对应的cell）
        if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
    // 3.覆盖数据
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
        _bannerHeadView.imageRadius = 10;// 设置卡片圆角
        _bannerHeadView.imageHeightPoor = 10;// 设置中间卡片与两边卡片的高度差
        
    }
    return _bannerHeadView;
}


@end

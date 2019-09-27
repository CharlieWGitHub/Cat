//
//  SettingViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/7.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "GestureLockView.h"
#import "CLoginViewController.h"
#import "VPNViewController.h"


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * personTable;
@property(nonatomic,strong) NSArray * dataArr;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    
    self.dataArr = @[ @"vpn",@"我的订单",@"我的收藏",@"我的评价",@"消息中心",@"清理缓存",@"设置"];
    
    [self.view addSubview:self.personTable];
    [self.personTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0 , 0, 15, 0));

    }];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * iden = @"identif";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }

    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row==0) {
        VPNViewController * vpn = [[VPNViewController alloc]init];
        vpn.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vpn animated:YES];
    }
    if (indexPath.row==3) {
        GestureLockView * gestures = [[GestureLockView alloc]init];
        gestures.hidesBottomBarWhenPushed = YES;
        gestures.gestureType = 0;
        [self.navigationController pushViewController:gestures animated:YES];
    }else if (indexPath.row ==1){
        AboutUsViewController * about = [[AboutUsViewController alloc]init];
        about.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:about animated:YES];
    }
    else if (indexPath.row ==2){
        CLoginViewController * login  =[[CLoginViewController alloc]init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }
}

#pragma mark layz
-(UITableView *)personTable{
    if (!_personTable) {
        _personTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _personTable.delegate = self;
        _personTable.dataSource = self;
        
    }
    return _personTable;
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

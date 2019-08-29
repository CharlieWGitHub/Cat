//
//  MessageCell.m
//  cat
//
//  Created by 王成龙 on 2019/8/29.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "MessageCell.h"
@interface MessageCell ()
@property (nonatomic,strong) UIView * headView;
@property (nonatomic,strong) UIView * bottomView;
@property (nonatomic,strong) NSMutableArray * buttonArray;
@end
@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatView];
    }
    return self;
}

- (void)creatView{
    [self.contentView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(kWidth(10));
        make.top.equalTo(self.contentView).with.offset(kWidth(10));
        make.right.equalTo(self.contentView).with.offset(kWidth(-10));
        make.height.mas_equalTo(kWidth(80));
    }];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kWidth(10));
        make.top.equalTo(self.headView.mas_bottom).with.offset(kWidth(1));
        make.right.equalTo(self.contentView).with.offset(kWidth(-10));
        make.height.mas_equalTo(kWidth(40));
    }];
//  --按钮--
    NSArray * titleArr = @[@"签到",@"问答",@"测评",@"话题",@"达人"];
    NSArray * imageArr = @[@"art",@"book",@"calendar",@"compose",@"dolly"];
  
    for (int i = 0; i<5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000+i;
        btn.frame = CGRectMake(15 + i * (lSCREEN_WIDTH-30)/5, 0,  (lSCREEN_WIDTH-30-80)/5, 80);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:HEXColor(@"0xbebebe") forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [self initButton:btn];
        [self.headView addSubview:btn];
        [self.buttonArray addObject:btn];
    }
// --头条---
    
}
//修改按钮的图片 文字位置
-(void)initButton:(UIButton*)btn{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height+20 ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-10.0, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}
#pragma mark private method
- (void)buttonClick:(UIButton*)button{
    
}
//下面轮埠的view
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor yellowColor];
    }
    return _bottomView;
}
//上面按钮的view
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headView.layer.cornerRadius = 10;
        _headView.layer.masksToBounds = YES;
        _headView.layer.borderColor =HEXColor(@"0xf6f6f6") .CGColor;
        _headView.layer.shadowColor = HEXColor(@"0xdddddd").CGColor;
        _headView.layer.shadowOffset = CGSizeMake(1, 3);
        _headView.layer.borderWidth = 1.0;
        
    }
    return _headView;
}
-(NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _buttonArray;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MessageCell.m
//  cat
//
//  Created by 王成龙 on 2019/8/29.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "MessageCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
@interface MessageCell ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) UIView * headView;
@property (nonatomic,strong) UIView * bottomView;
@property (nonatomic,strong) NSMutableArray * buttonArray;
@property (nonatomic,strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic,strong) UILabel * cycleTitleLable;
@property (nonatomic,strong) UIImageView * arrowImage;

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
 
    [self.contentView addSubview:self.bottomView];
   
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
    [self.bottomView addSubview:self.arrowImage];
    [self.bottomView addSubview:self.cycleTitleLable];
    [self.bottomView addSubview:self.cycleScrollView];
  
    
    self.cycleScrollView.titlesGroup = @[@"使用和不使用Masonry下的尺寸问题",@"讨论了masonry配合实现动画时候碰见的四种情形",@"动画中调用mas_updateConstrains升级他的约束",@"如果约束的是XIB的DIYView，masonry的约束可能和XIB中的约束冲突"];
}
-(void)layoutSubviews{
   
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(kWidth(10));
        make.top.equalTo(self.contentView).with.offset(kWidth(10));
        make.right.equalTo(self.contentView).with.offset(kWidth(-10));
        make.height.mas_equalTo(kWidth(80));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kWidth(10));
        make.top.equalTo(self.headView.mas_bottom).with.offset(kWidth(1));
        make.right.equalTo(self.contentView).with.offset(kWidth(-10));
        make.height.mas_equalTo(kWidth(40));
    }];
    
    [self.cycleTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).with.offset(kWidth(10));
        make.top.equalTo(self.bottomView);
        make.width.mas_equalTo(kWidth(40));
        make.height.mas_equalTo(kWidth(40));
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).offset(kWidth(-10));
        make.centerY.equalTo(self.bottomView.mas_centerY);
        
        make.width.mas_equalTo(kWidth(10));
        make.height.mas_equalTo(kWidth(20));
    }];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cycleTitleLable).offset(kWidth(40));
        make.center.mas_equalTo(self.bottomView.center);
        make.right.equalTo(self.arrowImage.mas_left).offset(kWidth(-15));
        make.height.mas_equalTo(kWidth(40));
    }];
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
//下面的view
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.layer.cornerRadius = 10;
        _bottomView.layer.masksToBounds = YES;
        _bottomView.layer.borderColor =HEXColor(@"0xf6f6f6") .CGColor;
        _bottomView.layer.shadowColor = HEXColor(@"0xdddddd").CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(1, 3);
        _bottomView.layer.borderWidth = 1.0;
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
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView  = [[SDCycleScrollView alloc]init];
//        _cycleScrollView.clipsToBounds             = YES;
        _cycleScrollView.backgroundColor           = [UIColor whiteColor];
        _cycleScrollView.onlyDisplayText           = YES;//文字
        _cycleScrollView.delegate                  = self;
        _cycleScrollView.showPageControl           = NO;
        _cycleScrollView.titleLabelTextColor       = HEXColor(@"0x808080");;
        _cycleScrollView.titleLabelTextFont        = [UIFont systemFontOfSize:15];
        _cycleScrollView.scrollDirection           = UICollectionViewScrollDirectionVertical;
        _cycleScrollView.titleLabelBackgroundColor = [UIColor whiteColor];
        _cycleScrollView.titleLabelTextAlignment   = NSTextAlignmentLeft;
        _cycleScrollView.autoScrollTimeInterval    = 4.0;
    }
    return _cycleScrollView;
}

-(UILabel *)cycleTitleLable{
    if (!_cycleTitleLable) {
        _cycleTitleLable = [[UILabel alloc]init];
        _cycleTitleLable.text = @"萌宠消息";
        _cycleTitleLable.numberOfLines = 0;
//     文本斜体
        CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-10 * (CGFloat)M_PI /180), 1, 0, 0);
        _cycleTitleLable.transform = matrix;
        _cycleTitleLable.textColor = HEXColor(@"0xf48c0d");
        _cycleTitleLable.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    }
    return _cycleTitleLable;
}
-(UIImageView *)arrowImage{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    }
    return _arrowImage;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

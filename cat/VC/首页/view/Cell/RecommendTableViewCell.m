//
//  RecommendTableViewCell.m
//  cat
//
//  Created by 王成龙 on 2019/8/30.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "RecommendTableViewCell.h"

@interface RecommendTableViewCell ()

@property (nonatomic ,strong) UIImageView  * headImg;//头像
@property (nonatomic ,strong) UIImageView  * tagImg;//标签头像上标签
@property (nonatomic ,strong) UILabel  * titleNameLab;//姓名
@property (nonatomic ,strong) NSString * titleString;//姓名字符串
@property (nonatomic ,strong) UILabel  * tagLab;//姓名后面的标签
@property (nonatomic ,strong) UILabel  * classifyLab;//分类标签
@property (nonatomic ,strong) UILabel  * numberOfBrowse;//浏览次数
@property (nonatomic ,strong) UIImageView * recommendImage;//图片
@property (nonatomic ,strong) UILabel  * recommendLab;//内容
@property (nonatomic ,strong) UILabel  * likeLab;//点赞数量
@property (nonatomic ,strong) UILabel  * commentLab;//评论数量


@end

@implementation RecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
//    [self.contentView addSubview:self.headImg];
////    [self.headImg addSubview:self.tagImg];
//    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(self.contentView).offset(15);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
    
    self.titleString = @"hello my good student";
//    [self.contentView addSubview:self.titleNameLab];
//    [self.titleNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.headImg);
//        make.left.equalTo(self.contentView).offset(55);
//        make.height.mas_equalTo(20);
//    }];
}

-(UIImageView *)headImg{
    if (!_headImg) {
        _headImg = [[UIImageView alloc]initWithImage:IMAGE(@"headImgPlaceHold")];
        _headImg.layer.cornerRadius = 15;
        _headImg.layer.borderColor = HEXColor(@"0xFFEBCD").CGColor;
        _headImg.layer.borderWidth = 1.f;
        _headImg.layer.masksToBounds = YES;
    }
    return _headImg;
}
-(UIImageView*)tagImg{
    if (!_tagImg) {
        _tagImg = [[UIImageView alloc]init];
        _tagImg.layer.cornerRadius = 5;
        _tagImg.layer.masksToBounds = YES;
    }
    return _tagImg;
}
-(UILabel *)titleNameLab{
    if (!_titleNameLab) {
        _titleNameLab = [[UILabel alloc]init];
        _titleNameLab.text = @"我爱郭振华";
        _titleNameLab.font = [UIFont systemFontOfSize:16.0];
        
    }
    return _titleNameLab;
}
-(UILabel *)tagLab{
    if (!_tagLab) {
        _tagLab = [[UILabel alloc]init];
        _tagLab.text = @"真好";
        _tagLab.font = [UIFont systemFontOfSize:14];
        
    }
    return _tagLab;
}
-(UILabel *)classifyLab{
    if (!_classifyLab) {
        _classifyLab = [[UILabel alloc]init];
        _classifyLab.text = @"盟主";
    }
    return _classifyLab;
}
/*浏览次数*/
-(UILabel *)numberOfBrowse{
    if (!_numberOfBrowse) {
        _numberOfBrowse = [[UILabel alloc]init];
        _numberOfBrowse.text = @"10000次浏览";
        _numberOfBrowse .font = [UIFont systemFontOfSize:14];
    }
    return _numberOfBrowse;
}
/*图片*/
-(UIImageView *)recommendImage{
    if (!_recommendImage) {
        _recommendImage = [[UIImageView alloc]init];
        _recommendImage.image = [UIImage imageNamed:@""];
    }
    return _recommendImage;
    
}
-(UILabel *)recommendLab{
    if (!_recommendLab) {
        _recommendLab = [[UILabel alloc]init];
        _recommendLab.text = @"下面是重写celldrawRect方法，把cell中的三部分进行绘制：";
        _recommendLab.numberOfLines = 0;
        _recommendLab.font = [UIFont systemFontOfSize:14];
        _recommendLab.textColor = [UIColor grayColor];
        
    }
    return _recommendLab;
}
/*点赞*/
- (UILabel *)likeLab{
    if (!_likeLab) {
        _likeLab = [[UILabel alloc]init];
        _likeLab.textColor = [UIColor redColor];
        _likeLab.text = @"219";
        _likeLab.font = [UIFont systemFontOfSize:14];
    }
    return _likeLab;
}
/*评论*/
-(UILabel *)commentLab{
    if (!_commentLab) {
        _commentLab = [[UILabel alloc]init];
        _commentLab.textColor = [UIColor blueColor];
        _commentLab.text = @"23";
        _commentLab.font = [UIFont systemFontOfSize:14];
    }
    return _commentLab;
}



/**
 重写视图方法绘制
 
 @param rect 坐标大小
 */
- (void)drawRect:(CGRect)rect {
    
    // 屏幕宽
//    CGFloat fScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    // 文本属性
    NSDictionary *dicAttribute;
    
    // 标题
    dicAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithWhite:0.2 alpha:1.0]};
//    [self.titleNameLab drawInRect:CGRectMake(10, 10, fScreenWidth - 20, 20) withAttributes:dicAttribute];
    [self.titleString drawInRect:CGRectMake(45, 15, 100, 30) withAttributes:dicAttribute];
    
    UIImage * imageView = [UIImage imageNamed:@"headImgPlaceHold"];
    [imageView drawInRect:CGRectMake(15, 15, 30, 30)];
    
    
 /*
    // 图片组
    // 图片宽
    CGFloat fImageWidth = (fScreenWidth - 40)/3;
    for (int i = 0; i < 3; i++) {
        
        UIImage *imgPicture = [UIImage imageNamed:self.arrImage[i]];
        [imgPicture drawInRect:CGRectMake(10 + i * (fImageWidth + 10), 40, fImageWidth, fImageWidth * 3/4)];
    }
    
    // 日期
    dicAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor colorWithWhite:0.6 alpha:1.0]};
    [self.strDate drawInRect:CGRectMake(10, 45 + fImageWidth * 3/4, fScreenWidth - 20, 20) withAttributes:dicAttribute];
    */
    // 分割线
//    [[UIColor colorWithWhite:0.9 alpha:1.0] set];
//    UIRectFill(CGRectMake(0, 65 + fImageWidth * 3/4, fScreenWidth, 5));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ItemSelectView.m
//  cat
//
//  Created by 王成龙 on 2019/8/28.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "ItemSelectView.h"
#import "UIView+frame.h"
#import "UIColor+Extension.h"

@implementation ItemSelectView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"ItemSelectView" owner:self options:nil].lastObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (IBAction)recommendBtnSelected:(id)sender {
    if (self.bottomLine.centerX !=self.recommendBtn.centerX) {
        self.bottomLine.centerX = self.recommendBtn.centerX;
        [self.recommendBtn setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
        [self.hotBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
        [self.followBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
        
        self.recommendBtn.titleLabel.font = kFont(24.0);
        self.hotBtn.titleLabel.font = kFont(15.0);
        self.followBtn.titleLabel.font = kFont(15.0);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedItemIndex:)]) {
            [self.delegate selectedItemIndex:1];
        }

    }
}

- (IBAction)hotBtnSelected:(id)sender {
    if (self.bottomLine.centerX!=self.hotBtn.centerX) {
        self.bottomLine.centerX = self.hotBtn.centerX;
     
        [self.recommendBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
        [self.hotBtn setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
        [self.followBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
        self.recommendBtn.titleLabel.font = kFont(15.0);
        self.hotBtn.titleLabel.font = kFont(24.0);
        self.followBtn.titleLabel.font = kFont(15.0);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedItemIndex:)]) {
            [self.delegate selectedItemIndex:2];
        }
    }
}

- (IBAction)followBtnSelected:(id)sender {
    if (self.bottomLine.centerX != self.followBtn.centerX) {
        self.bottomLine.centerX = self.followBtn.centerX;
       
        [self.recommendBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
        [self.hotBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
        [self.followBtn setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
        
        self.recommendBtn.titleLabel.font = kFont(15.0);
        self.hotBtn.titleLabel.font = kFont(15.0);
        self.followBtn.titleLabel.font = kFont(24.0);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedItemIndex:)]) {
            [self.delegate selectedItemIndex:3];
        }
    }
}

- (IBAction)searchButtonClicked:(id)sender {
    
}

-(void)updateItemSelectedIndex:(NSInteger)index{
    if (index==0) {
        if (self.bottomLine.centerX !=self.recommendBtn.centerX) {
            self.bottomLine.centerX = self.recommendBtn.centerX;
            [self.recommendBtn setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
            [self.hotBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
            [self.followBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
            
            self.recommendBtn.titleLabel.font = kFont(24.0);
            self.hotBtn.titleLabel.font = kFont(15.0);
            self.followBtn.titleLabel.font = kFont(15.0);
        }
    }else if (index ==1){
        if (self.bottomLine.centerX!=self.hotBtn.centerX) {
            self.bottomLine.centerX = self.hotBtn.centerX;
            
            [self.recommendBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
            [self.hotBtn setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
            [self.followBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
            self.recommendBtn.titleLabel.font = kFont(15.0);
            self.hotBtn.titleLabel.font = kFont(24.0);
            self.followBtn.titleLabel.font = kFont(15.0);
            
        }
    }else if (index ==2){
        if (self.bottomLine.centerX != self.followBtn.centerX) {
            self.bottomLine.centerX = self.followBtn.centerX;
            
            [self.recommendBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
            [self.hotBtn setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
            [self.followBtn setTitleColor:DEFAULTCOLOR forState:UIControlStateNormal];
            
            self.recommendBtn.titleLabel.font = kFont(15.0);
            self.hotBtn.titleLabel.font = kFont(15.0);
            self.followBtn.titleLabel.font = kFont(24.0);
            
        }
    }
}

@end

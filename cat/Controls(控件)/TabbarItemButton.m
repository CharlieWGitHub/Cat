//
//  TabbarItemButton.m
//  cat
//
//  Created by 王成龙 on 2019/8/9.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "TabbarItemButton.h"

static CGFloat const kIconHeight = 71;
static CGFloat const kTitleHeight = 30;

@implementation TabbarItemButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect rect = CGRectMake(0, (contentRect.size.height - kIconHeight - kTitleHeight) / 2, contentRect.size.width, kIconHeight);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect rect = CGRectMake(0, (contentRect.size.height - kIconHeight - kTitleHeight) / 2 + kIconHeight, contentRect.size.width, kTitleHeight);
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

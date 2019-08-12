//
//  UIButton+AdaptiveTitleAndImage.m
//  cat
//
//  Created by 王成龙 on 2019/8/11.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "UIButton+AdaptiveTitleAndImage.h"
#import <objc/runtime.h>


const void *spaceKey = "spaceKey";
const void *contentAdjustTypeKey = "contentAdjustTypeKey";


@implementation UIButton (AdaptiveTitleAndImage)

@dynamic adaptionType, spaceDefault;

- (void)beginAdjustContent
{
    [self beginAdjustContentWithMaxTitleWidth:0];
}
- (void)beginAdjustContentImageImmediately
{
    [self clBeginAdjustContentWithMaxTitleWidth:0];
}

- (void)beginAdjustContentWithMaxTitleWidth:(CGFloat)maxTtileWidth
{
    dispatch_async(dispatch_get_main_queue(), ^{
      [self clBeginAdjustContentWithMaxTitleWidth:maxTtileWidth];
    });
}
- (void)beginAdjustContentImmediatelyWithMaxTitleWidth:(CGFloat)maxTitleWidth
{
    [self clBeginAdjustContentWithMaxTitleWidth:maxTitleWidth];
}


- (void)clBeginAdjustContentWithMaxTitleWidth:(CGFloat)maxTitleWidth
{
    UIImage *btnImage = self.imageView.image;
    NSString *btnTitle = self.titleLabel.text;

    if (!btnImage || btnTitle.length <= 0) {
        NSAssert(false, @"请先设置按钮的图片以及文字");
        return;
    }

    CGSize imageSize = btnImage.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;

    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
    CGFloat titleWidth = titleSize.width;
    CGFloat titleHeight = titleSize.height;

    if (maxTitleWidth > 0 && titleWidth > maxTitleWidth) {
        titleWidth = maxTitleWidth;
    }

    CGFloat space = self.spaceDefault;

    switch (self.adaptionType) {
        case CLAdaptionTypeImageLeftTitleRight: {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, (space * 0.5), 0, -(space * 0.5))];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -(space * 0.5), 0, (space * 0.5))];
        } break;
        case CLAdaptionTypeImageRightTitleLeft: {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth + space * 0.5), 0, (imageWidth + space * 0.5))];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + space * 0.5), 0, -(titleWidth + space * 0.5))];
        } break;
        case CLAdaptionTypeImageUpTitleDown: {
            [self setTitleEdgeInsets:UIEdgeInsetsMake((titleHeight + space) * 0.5, -imageWidth * 0.5, -(titleHeight + space) * 0.5, imageWidth * 0.5)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(-(imageHeight + space) * 0.5, titleWidth * 0.5, (imageHeight + space) * 0.5, -titleWidth * 0.5)];
        } break;
        case CLAdaptionTypeImageDownTitleUp: {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-(titleHeight + space) * 0.5, -imageWidth * 0.5, (titleHeight + space) * 0.5, imageWidth * 0.5)];
            [self setImageEdgeInsets:UIEdgeInsetsMake((imageHeight + space) * 0.5, titleWidth * 0.5, -(imageHeight + space) * 0.5, -titleWidth * 0.5)];
        } break;
        default: {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, (space * 0.5), 0, -(space * 0.5))];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -(space * 0.5), 0, (space * 0.5))];
        } break;
    }
}

- (CGFloat)spaceDefault
{
    NSNumber *objc = objc_getAssociatedObject(self, spaceKey);
    if (!objc) {
        return 5;
    }
    return [objc floatValue];
}
- (void)setSpaceDefault:(CGFloat)spaceDefault
{
    objc_setAssociatedObject(self, spaceKey, @(self.spaceDefault), OBJC_ASSOCIATION_RETAIN);
}

- (CLAdaptionType)adaptionType
{
    NSNumber *objc = objc_getAssociatedObject(self, contentAdjustTypeKey);
    return [objc floatValue];
}
- (void)setAdaptionType:(CLAdaptionType)adaptionType
{
    objc_setAssociatedObject(self, contentAdjustTypeKey, @(adaptionType), OBJC_ASSOCIATION_RETAIN);
}


@end

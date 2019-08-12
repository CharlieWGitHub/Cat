//
//  UIButton+AdaptiveTitleAndImage.h
//  cat
//
//  Created by 王成龙 on 2019/8/11.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CLAdaptionType) {
    CLAdaptionTypeImageLeftTitleRight = 0, //default
    CLAdaptionTypeImageRightTitleLeft,
    CLAdaptionTypeImageUpTitleDown,
    CLAdaptionTypeImageDownTitleUp,
};


@interface UIButton (AdaptiveTitleAndImage)

@property (nonatomic, assign) CLAdaptionType adaptionType;
@property (nonatomic, assign) CGFloat spaceDefault;


/**
 开始调整内容
 调用前先设置好image wtitle
 默认在下一次的runLpoop进行更新
 */
- (void)beginAdjustContent;
/**
 直接更新
 */
- (void)beginAdjustContentImageImmediately;

/**
 可以传入的最大文字宽度

 @param maxTtileWidth 最大文字宽度
 */
- (void)beginAdjustContentWithMaxTitleWidth:(CGFloat)maxTtileWidth;

- (void)beginAdjustContentImmediatelyWithMaxTitleWidth:(CGFloat)maxTitleWidth;


@end

NS_ASSUME_NONNULL_END

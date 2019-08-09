//
//  PublishPopView.h
//  cat
//
//  Created by 王成龙 on 2019/8/9.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishPopView : UIView
/**
 弹出视图
 
 @param imgs 图片名字集合
 @param titles 文字集合
 @param selectBlock 点击的Item回调
 */
+ (void)showWithImages:(NSArray *)imgs titles:(NSArray *)titles selectBlock:(void (^)(NSInteger index))selectBlock;


@end

NS_ASSUME_NONNULL_END

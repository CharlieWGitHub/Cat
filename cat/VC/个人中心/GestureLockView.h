//
//  GestureLockView.h
//  cat
//
//  Created by 王成龙 on 2019/9/11.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, gestureType) {
    gestureTypeSet = 0,//设置
    gestureTypeVerify, //验证
    gestureTypeModify  //重置
};


@interface GestureLockView : BaseViewController
/**
 --样式--
 */
@property(nonatomic,assign)NSUInteger gestureType;

@end

NS_ASSUME_NONNULL_END

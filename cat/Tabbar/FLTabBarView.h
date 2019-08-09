//
//  FLTabBarView.h
//  FireLife
//
//  Created by 王成龙 on 2018/6/28.
//  Copyright © 2018年 charlie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CLItemType) {
    CLItemTypeHomePage = 10,
    CLItemTypeMessage = 11,
    CLItemTypeEmpty = 12,
    CLItemTypeShop = 13,
    CLItemTypeMe = 14,
    CLItemTypeLive = 100,
};

@class FLTabBarView;

@protocol CL_TabbarDelegate <NSObject>

- (void)tababr:(FLTabBarView *)tabbar clickButton:(CLItemType)index;

@end

@interface FLTabBarView : UIView

@property (nonatomic,weak) id <CL_TabbarDelegate> delegate;

@end

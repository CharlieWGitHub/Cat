//
//  ItemSelectView.h
//  cat
//
//  Created by 王成龙 on 2019/8/28.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ItemSelectDelegate <NSObject>

- (void)selectedItemIndex:(NSInteger)index;

@end

@interface ItemSelectView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UIButton *recommendBtn;

@property (weak, nonatomic) IBOutlet UIButton *hotBtn;

@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (nonatomic,weak)id <ItemSelectDelegate> delegate;

- (void) updateItemSelectedIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

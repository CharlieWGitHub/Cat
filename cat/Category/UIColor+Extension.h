//
//  UIColor+Extension.h
//  FireLife
//
//  Created by 王成龙 on 2018/7/7.
//  Copyright © 2018年 charlie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

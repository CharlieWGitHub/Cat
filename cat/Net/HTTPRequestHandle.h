//
//  HTTPRequestHandle.h
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//处理事件成功--返回数据
typedef void(^SuccessBlock)(id obj,id objTwo);
//处理失败  --返回错误信息
typedef void(^FailedBlock)(id obj,id objTwo);

@interface HTTPRequestHandle : NSObject


@end

NS_ASSUME_NONNULL_END

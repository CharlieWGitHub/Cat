//
//  CCProxy.h
//  cat
//
//  Created by 王成龙 on 2019/9/10.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//抽象基类-负责消息转发
@interface CCProxy : NSProxy
@property (weak ,nonatomic) id target;


@end

NS_ASSUME_NONNULL_END

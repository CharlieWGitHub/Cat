//
//  KeyChainStoreManager.h
//  cat
//
//  Created by 王成龙 on 2019/10/9.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStoreManager : NSObject

+ (NSString *)getUUIDByKeyChain;

@end

NS_ASSUME_NONNULL_END

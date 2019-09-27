//
//  NSMutableDictionary+SafeSetRemove.h
//  cat
//
//  Created by 王成龙 on 2019/9/26.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 *  Prevent value of dictionary is nil will cause crash.
 */

@interface NSMutableDictionary (SafeSetRemove)
/**
 Safe set key-value for dictionary.
 */
- (void)safeSetObject:(id)aObj
               forKey:(id<NSCopying>)aKey;

/**
 Safe read value for key.
 */
- (id)safeObjectForKey:(id<NSCopying>)aKey;
@end

NS_ASSUME_NONNULL_END

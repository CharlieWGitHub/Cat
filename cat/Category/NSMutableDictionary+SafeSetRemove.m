//
//  NSMutableDictionary+SafeSetRemove.m
//  cat
//
//  Created by 王成龙 on 2019/9/26.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "NSMutableDictionary+SafeSetRemove.h"

@implementation NSMutableDictionary (SafeSetRemove)

- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key) {
        return;
    }
    if (!obj) {
        [self removeObjectForKey:key];
    }
    else {
        [self setObject:obj forKey:key];
    }
}

- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey
{
    if (aObj && ![aObj isKindOfClass:[NSNull class]] && aKey) {
        [self setObject:aObj forKey:aKey];
    }
    else {
        return;
    }
}

- (id)safeObjectForKey:(id<NSCopying>)aKey
{
    if (aKey != nil) {
        return [self objectForKey:aKey];
    }
    else {
        return nil;
    }
}

@end

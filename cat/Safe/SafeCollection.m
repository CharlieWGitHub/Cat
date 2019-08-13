//
//  SafeCollection.m
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "SafeCollection.h"

@implementation SafeCollection

+ (NSDictionary *)dictionaryAtIndex:(NSUInteger)index fromArray:(NSArray *)array
{
    return [self objectOfKind:[NSDictionary class] atIndex:index fromArray:array];
}

+ (NSArray *)arrayAtIndex:(NSUInteger)index fromArray:(NSArray *)array
{
    return [self objectOfKind:[NSArray class] atIndex:index fromArray:array];
}

+ (NSString *)stringAtIndex:(NSUInteger)index fromArray:(NSArray *)array
{
    return [self objectOfKind:[NSString class] atIndex:index fromArray:array];
}

+ (NSNumber *)numberAtIndex:(NSUInteger)index fromArray:(NSArray *)array;
{
    return [self objectOfKind:[NSNumber class] atIndex:index fromArray:array];
}

+ (id)objectOfKind:(Class)cls atIndex:(NSUInteger)index fromArray:(NSArray *)array
{
    if (![array isKindOfClass:[NSArray class]] || array.count <= index) {
        return nil;
    }
    
    id obj = [array objectAtIndex:index];
    if (![obj isKindOfClass:cls]) {
        return nil;
    }
    
    return obj;
}

#pragma mark - Dictionary

+ (NSDictionary *)dictionaryForKey:(id)key fromDictionary:(NSDictionary *)dictionary
{
    return [self objectOfKind:[NSDictionary class] forKey:key fromDictionary:dictionary];
}

+ (NSArray *)arrayForKey:(id)key fromDictionary:(NSDictionary *)dictionary
{
    return [self objectOfKind:[NSArray class] forKey:key fromDictionary:dictionary];
}

+ (NSString *)stringForKey:(id)key fromDictionary:(NSDictionary *)dictionary
{
    return [self objectOfKind:[NSString class] forKey:key fromDictionary:dictionary];
}

+ (NSNumber *)numberForKey:(id)key fromDictionary:(NSDictionary *)dictionary
{
    return [self objectOfKind:[NSNumber class] forKey:key fromDictionary:dictionary];
}

+ (id)objectOfKind:(Class)cls forKey:(id)key fromDictionary:(NSDictionary *)dictionary
{
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    id obj = [dictionary objectForKey:key];
    
    if (![obj isKindOfClass:cls]) {
        if ([obj isKindOfClass:[NSNull class]]) {
            return nil;
        }
        
        //特殊处理NSString类型数据
        if ([cls isSubclassOfClass:[NSString class]]) {
            return obj;
        }
        return nil;
    }
    
    return obj;
}

+ (NSString *)checkOutNullString:(NSString *)string
{
    if ([string isKindOfClass:[NSString class]] && string != nil) {
        return string;
    }
    
    return @"";
}


@end

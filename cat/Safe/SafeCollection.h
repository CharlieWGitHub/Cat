//
//  SafeCollection.h
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeCollection : NSObject

/*!
 @abstract
 Looks up for dictionary at given index.
 If index is out of range - nil is returned and no exception is generated.
 If object at that index is not kind of NSDictionary - this method returns nil.
 
 @param index any unsigned integer, non-existing index will not cause exceptions.
 
 @param array Array to look into, should be kind of NSArray, if it's not - this method returns nil.
 */
+ (NSDictionary *)dictionaryAtIndex:(NSUInteger)index fromArray:(NSArray *)array;

/*!
 @abstract
 Looks up for array at given index.
 If index is out of range - nil is returned and no exception is generated.
 If object at that index is not kind of NSArray - this method returns nil.
 
 @param index any unsigned integer, non-existing index will not cause exceptions.
 
 @param array Array to look into, should be kind of NSArray, if it's not - this method returns nil.
 */
+ (NSArray *)arrayAtIndex:(NSUInteger)index fromArray:(NSArray *)array;

/*!
 @abstract
 Looks up for string at given index.
 If index is out of range - nil is returned and no exception is generated.
 If object at that index is not kind of NSString - this method returns nil.
 
 @param index any unsigned integer, non-existing index will not cause exceptions.
 
 @param array Array to look into, should be kind of NSArray, if it's not - this method returns nil.
 */
+ (NSString *)stringAtIndex:(NSUInteger)index fromArray:(NSArray *)array;

/*!
 @abstract
 Looks up for number at given index.
 If index is out of range - nil is returned and no exception is generated.
 If object at that index is not kind of NSNumber - this method returns nil.
 
 @param index any unsigned integer, non-existing index will not cause exceptions.
 
 @param array Array to look into, should be kind of NSArray, if it's not - this method returns nil.
 */
+ (NSNumber *)numberAtIndex:(NSUInteger)index fromArray:(NSArray *)array;

/*!
 @abstract
 Looks up for instance of given class at given index.
 If index is out of range - nil is returned and no exception is generated.
 If object at that index is not kind of given class - this method returns nil.
 
 @param index any unsigned integer, non-existing index will not cause exceptions.
 
 @param array Array to look into, should be kind of NSArray, if it's not - this method returns nil.
 */
+ (id)objectOfKind:(Class)cls atIndex:(NSUInteger)index fromArray:(NSArray *)array;
/*!
 @abstract
 Looks up for dictionary for given key.
 If object for that key is not kind of NSDictionary - this method returns nil.
 
 @param key dictionary key to look for.
 
 @param dictionary Dictionary to look into, should be kind of NSDictionary, if it's not - this method returns nil.
 */
+ (NSDictionary *)dictionaryForKey:(id)key fromDictionary:(NSDictionary *)dictionary;
/*!
 @abstract
 Looks up for array for given key.
 If object for that key is not kind of NSArray - this method returns nil.
 
 @param key dictionary key to look for.
 
 @param dictionary Dictionary to look into, should be kind of NSDictionary, if it's not - this method returns nil.
 */
+ (NSArray *)arrayForKey:(id)key fromDictionary:(NSDictionary *)dictionary;


/*!
 @abstract
 Looks up for string for given key.
 If object for that key is not kind of NSString - this method returns nil.
 
 @param key dictionary key to look for.
 
 @param dictionary Dictionary to look into, should be kind of NSDictionary, if it's not - this method returns nil.
 */
+ (NSString *)stringForKey:(id)key fromDictionary:(NSDictionary *)dictionary;


/*!
 @abstract
 Looks up for number at for given key.
 If index is out of range - nil is returned and no exception is generated.
 If object at that index is not kind of NSNumber - this method returns nil.
 
 @param key dictionary key to look for.
 
 @param dictionary Dictionary to look into, should be kind of NSDictionary, if it's not - this method returns nil.
 */
+ (NSNumber *)numberForKey:(id)key fromDictionary:(NSDictionary *)dictionary;

/*!
 @abstract
 Looks up for instance of given class for given key.
 If object at that index is not kind of given class - this method returns nil.
 
 @param key dictionary key to look for.
 
 @param dictionary Dictionary to look into, should be kind of NSDictionary, if it's not - this method returns nil.
 */
+ (id)objectOfKind:(Class)cls forKey:(id)key fromDictionary:(NSDictionary *)dictionary;

/*!
 @abstract
 checkout object ，if object is Null，return @“ ”；
 @param string 输入的对象 如果对象为空，返回空字符串
 
 */
+ (NSString *)checkOutNullString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END

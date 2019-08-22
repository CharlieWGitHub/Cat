//
//  NSString+Encode.h
//  cat
//
//  Created by 王成龙 on 2019/8/19.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encode)

/**
 *  对字符串进行base64编码
 *  @return 返回编码之后的字符串
 */
- (nullable NSString *)base64Encode;

#pragma mark - Base64解码
/**
 *  对编码之后的字符串进行解码
 *  @return 返回解码之后的字符串
 */
- (nullable NSString *)base64Decode;

/**
 url编码
 
 @param characterSetStr 需要转义的特殊字符，例如@"/+=\n"
 @return 返回编码后的字符串
 */
-(nullable NSString *)urlEncodeWithCharacterSet:(nullable NSString *)characterSetStr;

/**
 url解码
 
 @return 解码后字符串
 */
-(nullable NSString *)urlDecode;
@end

NS_ASSUME_NONNULL_END

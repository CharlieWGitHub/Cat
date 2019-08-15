//
//  SafeInspactionClasss.h
//  cat
//
//  Created by 王成龙 on 2019/8/14.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeInspactionClasss : NSObject

/**
 对一个字符串进行base64编码,并且返回
 
 @param string 需要操作的字符串
 @return 编码后的字符串
 */
+ (NSString *)base64EncodeString:(NSString *)string;

/**
 对base64编码之后的字符串解码,并且返回
 
 @param string 需要解码的字符串
 @return 解码后的字符串
 */
+ (NSString *)base64DecodeString:(NSString *)string;


//****** base64 -> hex
+ (NSString *)stringFromByte:(Byte)byteVal;
+ (NSString *)hexStringFromData:(NSData *)data;
+ (NSData *)base64Decode:(NSString *)string;


//****** hex  ->base64
+ (NSData *)dataWithHexString:(NSString *)hexString;
+ (NSString *)base64Encode:(NSData *)data;

/**普通字符串转hex */
+ (NSString *)hexStringFromString:(NSString *)string;


/**
 十进制转换十六进制

 @param decimal 十进制数
 @return 十六进制Hex
 */
+ (NSString *)getHexByDecimal:(NSInteger)decimal;

@end

NS_ASSUME_NONNULL_END

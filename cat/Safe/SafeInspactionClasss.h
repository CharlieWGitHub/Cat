//
//  SafeInspactionClasss.h
//  cat
//
//  Created by 王成龙 on 2019/8/14.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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


/**
 计算宽度

 @param string 需要计算的字符串
 @param height 固定高度
 @param font 字符串的大小
 @return 返回字符串的宽度
 */
+ (CGFloat)widthOfString:(NSString *)string height:(CGFloat)height font:(UIFont *)font;

/**
 计算高度

 @param string 需要计算的字符串
 @param width 固定宽度
 @param font 字符串的大小
 @return 返回值
 */
+ (CGFloat)heightOfString:(NSString *)string width:(CGFloat)width font:(UIFont *)font;


/**
 获取当前时间

 @return 当前时间 2019-9-16 13：27：39
 */
+ (NSString *)getCurrentDate;


/**
 获取当前时间戳

 @return 当前时间戳 235672356253
 */
+ (NSString *)getCurrentTimestamp;


/**
 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒

 @param str 时间戳
 @return 时间
 */
+ (NSString *)getDateStringWithTimestamp:(NSString *)str;


/**
 时间转时间戳

 @param str 字符串转时间戳 如：2017-4-10 17:15:10
 @return 时间戳
 */
+ (NSString *)getTimestampWithDate:(NSString *)str;


@end

NS_ASSUME_NONNULL_END

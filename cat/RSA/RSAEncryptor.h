//
//  RSAEncryptor.h
//  cat
//
//  Created by 王成龙 on 2019/8/19.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAEncryptor : NSObject
/**
 * 加密方法
 *
 * @param str 需要加密的字符串
 * @param path '.der'格式的公钥文件路径
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;


/**
 * 解密方法
 *
 * @param str 需要解密的字符串
 * @param path '.p12'格式的私钥文件路径
 * @param password 私钥文件密码
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

/**
 * 加密方法
 *
 * @param str 需要加密的字符串
 * @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 * 解密方法
 *
 * @param str 需要解密的字符串
 * @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;

@end

NS_ASSUME_NONNULL_END

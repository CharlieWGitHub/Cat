//
//  NetWorkHeader.h
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkHeader : NSObject
/**
 * @brief 用户ID。
 */
@property (nonatomic, copy) NSString *userID;

/*!
 *  @brief  客户端Id,用户App的唯一标识。
 *
 *  @since 1.0
 */
@property (nonatomic, copy) NSString *clientId;

/*!
 *  @brief  用户成功登录之后的accessToken。
 *
 *  @since 1.0
 */
@property (nonatomic, copy) NSString *accessToken;

/*!
 *  @brief  sequenceId:报文流水(客户端唯一) 客户端交易流水号。20 位, 前 14 位时间戳,后 6 位流水 号。
 *
 *  @since 1.0
 */
@property (nonatomic, copy) NSString *sequenceId;

/*!
 *  @brief  sign:存放数字签名摘要或组件密码认证：开放平台会为每个调用方分发一个appKey,调用方系统需要用请求报文中的BODY体业务信息+SecretKey最后组合成字符串，采用MD5加密方式生成摘要.
 *
 *  @since 1.0
 */

@property (nonatomic, copy) NSString *sign;

+ (NetWorkHeader*)defaultHeader;

/**
 * @brief 获取AppServer接口HTTP Header的方法。
 * @param bodyDictionary HTTP请求POST的body数据对象。
 * @return 拼装好的Header字典对象。
 */
+ (NSDictionary *)getNewAPPserverHttpHeader:(NSDictionary *)bodyDictionary;


@end

NS_ASSUME_NONNULL_END

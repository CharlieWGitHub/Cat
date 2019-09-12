//
//  HTTPRequestManager.h
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "SafeCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTPRequestManager : NSObject

+ (void)postRequestWithUrl:(NSString *)url
                   headers:(NSDictionary *)header
                      body:(id)body
               onOperation:(void (^)(AFHTTPRequestOperation *onOperation))onOperation
                completion:(void (^)(NSDictionary *responseDic))completion
                     error:(void (^)(NSError *connectError, long responseStatusCode))onError;

+ (void)getRequestWithUrl:(NSString *)url
                  headers:(NSDictionary *)header
               parameters:(id)parmeters
              onOperation:(void (^)(AFHTTPRequestOperation *onOperation))onOperation
               completion:(void (^)(NSDictionary *responseDic))completion
                    error:(void (^)(NSError *connectError, long responseStatusCode))onError;

+ (void)postDataRequestWithUrl:(NSString *)url
                       headers:(NSDictionary *)header
                          body:(id)body
                      fileData:(NSData *)fileData
                   OnOperation:(void (^)(AFHTTPRequestOperation *onOperation))onOperation
                    completion:(void (^)(NSDictionary *responseDic))completion
                         error:(void (^)(NSError *connectError, long responseStatusCode))onError;


/**
 上传方法

 @param url 上传地址
 @param header 头
 @param parmeter 参数
 @param dataArray 需要上传的数据
 @param onOperation opreation
 @param completion 成功回调
 @param onError 失败回调
 */
+ (void)uploadDataRequestWithUrl:(NSString *)url
                         headers:(NSDictionary *)header
                       parmeters:(id)parmeter
                       dataArray:(NSArray *)dataArray
                     onOperation:(void (^)(AFHTTPRequestOperation *onOperation))onOperation
                      completion:(void (^)(NSDictionary *responseDic))completion
                           error:(void (^)(NSError *connectError, long responseStatusCode))onError;
;

@end

NS_ASSUME_NONNULL_END

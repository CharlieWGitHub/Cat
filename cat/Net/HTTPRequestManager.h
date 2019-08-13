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
               onOperation:(void (^)(AFHTTPRequestOperation * onOperation))onOperation
                completion:(void(^)(NSDictionary *responseDic))completion
                     error:(void(^)(NSError * connectError,long responseStatusCode))onError;

+ (void)getRequestWithUrl:(NSString *)url
                  headers:(NSDictionary*)header
               parameters:(id)parmeters
              onOperation:(void(^)(AFHTTPRequestOperation*onOperation))onOperation
               completion:(void(^)(NSDictionary*responseDic))completion
                    error:(void(^)(NSError * connectError,long responseStatusCode))onError;

+ (void)postDataRequestWithUrl:(NSString *)url
                       headers:(NSDictionary *)header
                          body:(id)body
                      fileData:(NSData *)fileData
                   OnOperation:(void (^)(AFHTTPRequestOperation *onOperation))onOperation
                    completion:(void (^)(NSDictionary *responseDic))completion
                         error:(void (^)(NSError *connectError, long responseStatusCode))onError;

/**
 上传方法

 @param url <#url description#>
 @param header <#header description#>
 @param parmeter <#parmeter description#>
 @param dataArray <#dataArray description#>
 @param datatype <#datatype description#>
 @param onOperation <#onOperation description#>
 @param completion <#completion description#>
 @param onError <#onError description#>
 */
+ (void)uploadDataRequestWithUrl:(NSString *)url
                         headers:(NSDictionary*)header
                       parmeters:(id)parmeter
                       dataArray:(NSArray *)dataArray
                        dataType:(NSString *)datatype
                     onOperation:(void(^)(AFHTTPRequestOperation*onOperation))onOperation
                completion:(void(^)(NSDictionary*responseDic))completion
                           error:(void(^)(NSError * connectError,long responseStatusCode))onError;;

@end

NS_ASSUME_NONNULL_END

//
//  HTTPRequestManager.m
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "HTTPRequestManager.h"
#import <AFNetworking.h>

@implementation HTTPRequestManager
+ (void)setHTTPHeaderField:(NSDictionary *)header AFHTTPSessionManager:(AFHTTPSessionManager *)manager
{
    if (header.count > 0) {
        for (NSString *key in header) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
}

+ (void)postRequestWithUrl:(NSString *)url headers:(NSDictionary *)header body:(id)body onOperation:(void (^)(AFHTTPRequestOperation *onOperation))onOperation completion:(void (^)(NSDictionary *_Nonnull responseDic))completion error:(void (^)(NSError *_Nonnull connectError, long responseStatusCode))onError
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [self setHTTPHeaderField:header AFHTTPSessionManager:manager];

    [manager POST:url
        parameters:body
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
          onOperation((AFHTTPRequestOperation *)task);
          NSDictionary *dic = nil;
          if ([responseObject isKindOfClass:[NSDictionary class]]) {
              dic = (NSDictionary *)responseObject;
          }
          completion(dic);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
          onOperation((AFHTTPRequestOperation *)task);
          onError(error, ((NSHTTPURLResponse *)task.response).statusCode);
        }];
}
//上传
+ (void)postDataRequestWithUrl:(NSString *)url headers:(NSDictionary *)header body:(id)body fileData:(NSData *)fileData OnOperation:(void (^)(AFHTTPRequestOperation *_Nonnull))onOperation completion:(void (^)(NSDictionary *_Nonnull))completion error:(void (^)(NSError *_Nonnull, long))onError
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [self setHTTPHeaderField:header AFHTTPSessionManager:manager];
    [manager POST:url
        parameters:body
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
          if (fileData) {
              NSDate *date = [NSDate date];
              NSTimeZone *zone = [NSTimeZone systemTimeZone];
              NSInteger interval = [zone secondsFromGMTForDate:date];
              NSDate *localeDate = [date dateByAddingTimeInterval:interval];
              NSDateFormatter *timeFormatHour = [[NSDateFormatter alloc] init];
              [timeFormatHour setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
              [timeFormatHour setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
              NSString *nowPathTime = [timeFormatHour stringFromDate:localeDate];
              /**
 appendPartWithFileData：要上传的二进制流
 name：对应网站上处理文件的名字
 fileName：要保存在服务器上的文件名字
 mimeType：长传文件的类型
 */
              [formData appendPartWithFileData:fileData name:@"file_1" fileName:[NSString stringWithFormat:@"%@.zip", nowPathTime] mimeType:@"application/zip"];
          }
        }
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
          onOperation((AFHTTPRequestOperation *)task);
          NSDictionary *dic = nil;
          if ([responseObject isKindOfClass:[NSDictionary class]]) {
              dic = (NSDictionary *)responseObject;
          }
          completion(dic);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
          onOperation((AFHTTPRequestOperation *)task);
          onError(error, ((NSHTTPURLResponse *)task.response).statusCode);
        }];
}

+ (void)getRequestWithUrl:(NSString *)url headers:(NSDictionary *)header parameters:(id)parmeters onOperation:(void (^)(AFHTTPRequestOperation *_Nonnull))onOperation completion:(void (^)(NSDictionary *_Nonnull))completion error:(void (^)(NSError *_Nonnull, long))onError
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [self setHTTPHeaderField:header AFHTTPSessionManager:manager];
    [manager GET:url
        parameters:parmeters
        progress:^(NSProgress *_Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
          onOperation((AFHTTPRequestOperation *)task);
          NSDictionary *dic = nil;
          if ([responseObject isKindOfClass:[NSDictionary class]]) {
              dic = (NSDictionary *)responseObject;
          }
          completion(dic);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
          onOperation((AFHTTPRequestOperation *)task);
          onError(error, ((NSHTTPURLResponse *)task.response).statusCode);
        }];
}

+ (void)uploadDataRequestWithUrl:(NSString *)url headers:(NSDictionary *)header parmeters:(id)parmeter dataArray:(NSArray *)dataArray onOperation:(void (^)(AFHTTPRequestOperation *_Nonnull))onOperation completion:(void (^)(NSDictionary *_Nonnull))completion error:(void (^)(NSError *_Nonnull, long))onError
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [self setHTTPHeaderField:header AFHTTPSessionManager:manager];
    [manager POST:url
        parameters:parmeter
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

          if (dataArray.count > 0) {
              for (int i = 0; i < dataArray.count; i++) {
                  UIImage *image = dataArray[i];
                  NSData *imageData = UIImagePNGRepresentation(image);
                  NSDate *date = [NSDate date];
                  NSTimeZone *zone = [NSTimeZone systemTimeZone];
                  NSInteger interval = [zone secondsFromGMTForDate:date];
                  NSDate *localeDate = [date dateByAddingTimeInterval:interval];
                  NSDateFormatter *timeFormatHour = [[NSDateFormatter alloc] init];
                  [timeFormatHour setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
                  [timeFormatHour setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                  NSString *nowPathTime = [timeFormatHour stringFromDate:localeDate];
                  /*
                 appendPartWithFileData：要上传的二进制流
                 name：上传文件的远程服务中接收文件使用的字段名称
                 fileName：要保存在服务器上的文件名字
                 mimeType：长传文件的类型
                 */
                  [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"photos[%d]", i] fileName:[NSString stringWithFormat:@"%@image%d.png", nowPathTime, i] mimeType:@"image/png"];
              }
          }
        }
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
          onOperation((AFHTTPRequestOperation *)task);
          NSDictionary *dic = nil;
          if ([responseObject isKindOfClass:[NSDictionary class]]) {
              dic = (NSDictionary *)responseObject;
          }
          completion(dic);
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
          onOperation((AFHTTPRequestOperation *)task);
          onError(error, ((NSHTTPURLResponse *)task.response).statusCode);
        }];
}

@end

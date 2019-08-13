//
//  LoginHandle.m
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "LoginHandle.h"

@implementation LoginHandle

+(void)loadWithName:(NSString *)name passworld:(NSString *)passworld success:(nonnull SuccessBlock)success failed:(nonnull FailedBlock)failed{
    
    NSString *urlstring = [NSString stringWithFormat:@"%@%@", @"", @""];
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setObject:name forKey:@"name"];
    [body setObject:passworld forKey:@"passworld"];
    NSDictionary *header = [NetWorkHeader getNewAPPserverHttpHeader:body];
    
    [HTTPRequestManager postRequestWithUrl:urlstring headers:header body:body onOperation:^(AFHTTPRequestOperation * _Nonnull onOperation) {
        
    } completion:^(NSDictionary * _Nonnull responseDic) {
        if ([responseDic[@"code"] isEqualToString:@"success"]&& responseDic[@"data"] != [NSNull null]) {
//          检查是否是字典
            NSDictionary *dataDic = [SafeCollection dictionaryForKey:@"data" fromDictionary:responseDic];
            NSArray<NSDictionary *> *roomDictArray = [SafeCollection arrayForKey:@"rooms" fromDictionary:dataDic];
            CCLog(@"%@",roomDictArray);
//          回调
            if (success) {
                success(dataDic,roomDictArray);
            }
        }
    } error:^(NSError * _Nonnull connectError, long responseStatusCode) {
        
    }];
    
    
}
@end

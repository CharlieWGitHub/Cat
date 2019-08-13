//
//  NetWorkHeader.m
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "NetWorkHeader.h"
#import "UPMD5.h"

NSString *const UNAppId = @"appId";
NSString *const UNAppVersion = @"appVersion";
NSString *const UNAppKey = @"appKey";
NSString *const UNClientId = @"clientId";
NSString *const UNSequenceId = @"sequenceId";
NSString *const UNAccessToken = @"accessToken";
NSString *const UNSign = @"sign";
NSString *const kUNUserID = @"kUNUserID";

#define UNVAppId @"com.duotePet.cat"
#define UNVAppVersion @"1.0"
#define UNVAppKey @"abcdefghijklmnopqrstuvwxyz123456789"

#define UNVClientId [self defaultHeader].clientId
#define UNVSequenceId [self defaultHeader].sequenceId
#define UNVAccessToken [self defaultHeader].accessToken

@implementation NetWorkHeader

+(NetWorkHeader *)defaultHeader{
    static NetWorkHeader * shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NetWorkHeader alloc]init];
    });
    return shareInstance;
}

+ (NSDictionary *)getNewAPPserverHttpHeader:(NSDictionary *)bodyDictionary{
   
    NSString *appId = @"com.duotePet.cat";
    NSString *sequenceId = [NetWorkHeader defaultHeader].sequenceId;
    NSString *clientId = [NetWorkHeader defaultHeader].clientId;
    NSString *appKey = @"abcdefghijklmnopqrstuvwxyz123456789";
    NSString *accessToken = [NetWorkHeader defaultHeader].accessToken;
    NSString *appversion = @"1.0";
    NSString *sign = [self obtainSign:bodyDictionary withSequenceId:sequenceId];
    
    return @{ UNAppId : appId,
              @"timestamp" : [sequenceId substringToIndex:14],
              UNClientId : clientId,
              UNAppKey : appKey,
              UNAccessToken : accessToken,
              UNAppVersion : appversion,
              UNSign : sign };
}

+ (NSString *)obtainSign:(NSDictionary *)bodyDict withSequenceId:(NSString *)seqId
{
    NSString *bodyStr;
    if (bodyDict != nil) {
        NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDict options:NSJSONWritingPrettyPrinted error:nil];
        bodyStr = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
        bodyStr = [bodyStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        bodyStr = [bodyStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        bodyStr = [bodyStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        bodyStr = [bodyStr stringByReplacingOccurrencesOfString:@"\b" withString:@""];
        bodyStr = [bodyStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    }
    NSString *timestamp = @"";
    if (seqId.length > 14) {
        timestamp = [seqId substringToIndex:14];
    }
    else {
        timestamp = seqId;
    }
    
    NSString *signKeyStr;
    if (bodyDict == nil) {
        signKeyStr = [NSString stringWithFormat:@"%@%@%@", UNVAppId, UNVAppKey, timestamp];
    }
    else {
        signKeyStr = [NSString stringWithFormat:@"%@%@%@%@", bodyStr, UNVAppId, UNVAppKey, timestamp];
    }
    return [UPMD5 getMd5:signKeyStr];
}

@end

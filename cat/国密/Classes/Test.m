
//
//  Test.m
//  cat
//
//  Created by 王成龙 on 2019/8/28.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "Test.h"
#import "SafeInspactionClasss.h"
#import "NSString+HASH.h"
#import "RSAEncryptor.h"
#import "NSString+Encode.h"
#import "PBGMService.h"

@implementation Test
//GCD 信号量的使用
/**
 这个方法会使信号量加一
 dispatch_semaphore_signal
 这个方法会使信号量减一
 dispatch_semaphore_wait
 当信号量是0时候 第二个方法会阻塞，不会向下执行，知道信号量不为0
 */
- (void)method{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"完成任务——%d",i);
                //              延迟 4 秒
                sleep(4);
                dispatch_semaphore_signal(semaphore);
                NSLog(@"当前线程：%@",[NSThread currentThread]);
            });
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        NSLog(@"任务全部执行完成");
    });
}
- (void)testsm2{
    
    NSString *priviteKey = @"128B2FA8BD433C6C068C8D803DFF79792A519A55171B1B650C23661D15897263";
    NSString * sm3HashString = @"message digest";
    //  签名、验证签名
    NSString *uid = @"ALICE123@YAHOO.COM";
    NSString *signedString = [[PBGMService shared] sm2_signPlainString:sm3HashString withUID:uid withPrivateKey:priviteKey];
    NSLog(@"signed string:%@ \n 长度=%lu", signedString,(unsigned long)signedString.length);
    NSLog(@"验证：签名是否是正确");
    
    NSString * pubkey = @"0AE4C7798AA0F119471BEE11825BE46202BB79E2A5844495E97C04FF4DF2548A7C0240F88F1CD4E16352A73C17B7F16F07353E53A176D684A9FE0C6BB798E857";
    BOOL isSc = [[PBGMService shared]sm2_verifyWithPlainString:sm3HashString withSigned:signedString withUID:uid withPublicKey:pubkey];
    NSLog(@"验证：%@",isSc?@"YES":@"NO");
}

- (void)hashMethodAndRSA{
    
    NSString * normalString = @"123456789abcdefghijklmnopqrstuvwxyz";
    NSString * publickKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQK/4acwS39YXwbS+IlHsPSQIDAQAB";
    NSString * privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANNtnpw0f0+B0XrRpAq94vPcVNqXLMdDBunrTXLvtLOYYdfcXk2hVRlt0rtQx2gIsrgUHOJN7BgP0Na8AStdmj0EW4j3psCinzB+XVWRnLIdNzOfE0kUZJB38HvT8TEyAwGkTCQAB3JSoiMh1UaHUVAr/hpzBLf1hfBtL4iUew9JAgMBAAECgYA1tGeQmAkqofga8XtwuxEWDoaDS9k0+EKeUoXGxzqoT/GyiihuIafjILFhoUA1ndf/yCQaG973sbTDhtfpMwqFNQq13+JAownslTjWgr7Hwf7qplYW92R7CU0v7wFfjqm1t/2FKU9JkHfaHfb7qqESMIbO/VMjER9o4tEx58uXDQJBAO0O4lnWDVjr1gN02cqvxPOtTY6DgFbQDeaAZF8obb6XqvCqGW/AVms3Bh8nVlUwdQ2K/xte8tHxjW9FtBQTLd8CQQDkUncO35gAqUF9Bhsdzrs7nO1J3VjLrM0ITrepqjqtVEvdXZc+1/UrkWVaIigWAXjQCVfmQzScdbznhYXPz5fXAkEAgB3KMRkhL4yNpmKRjhw+ih+ASeRCCSj6Sjfbhx4XaakYZmbXxnChg+JB+bZNz06YBFC5nLZM7y/n61o1f5/56wJBALw+ZVzE6ly5L34114uG04W9x0HcFgau7MiJphFjgUdAtd/H9xfgE4odMRPUD3q9Me9LlMYK6MiKpfm4c2+3dzcCQQC8y37NPgpNEkd9smMwPpSEjPW41aMlfcKvP4Da3z7G5bGlmuICrva9YDAiaAyDGGCK8LxC8K6HpKrFgYrXkRtt";
    
    //服务器传输过来的公钥字符串是这个样子的
    NSString *RSAPublickKeyFromServer = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd%2FB70%2FExMgMBpEwkAAdyUqIjIdVGh1FQK%2F4acwS39YXwbS%2BIlHsPSQIDAQAB";
    
    //经过URL解码后和RSAPublickKey一样
    NSString *urlDecodePublicKey = RSAPublickKeyFromServer.urlDecode;
    if ([urlDecodePublicKey isEqualToString:publickKey]) {
        CCLog(@"解码后和公钥一致");
    }else{
        CCLog(@"解码后和公钥不一致");
    }
    //测试一下编码
    NSString *urlEncodePublicKey = [publickKey urlEncodeWithCharacterSet:@"/+=\n"];
    if ([urlEncodePublicKey isEqualToString:RSAPublickKeyFromServer]) {
        CCLog(@"编码后和服务器传过来的一致");
    }else{
        CCLog(@"编码后和服务器传过来的不一致");
    }
    
    NSString * encryptStr = [RSAEncryptor encryptString:normalString publicKey:publickKey];
    
    NSString * decryptStr = [RSAEncryptor decryptString:encryptStr privateKey:privateKey];
    
    CCLog(@"加密：%@\n解密：%@",encryptStr,decryptStr);
    
}

@end

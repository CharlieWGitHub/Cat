//
//  KeyChainStoreManager.m
//  cat
//
//  Created by 王成龙 on 2019/10/9.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "KeyChainStoreManager.h"
#import "KeychainManager.h"
#import <AdSupport/AdSupport.h>

@implementation KeyChainStoreManager

+ (NSString *)getUUIDByKeyChain{
    NSString * strUUID = (NSString *)[KeychainManager keyChainReadData:@"com.duotePet.car.charlie"];
   
    if ([strUUID isEqualToString:@""] || !strUUID) {
    
        strUUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
         if(strUUID.length == 0 || [strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"])
                {
                    //生成一个uuid的方法
                    CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
                    strUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
                    CFRelease(uuidRef);
                }
        [KeychainManager keyChainSaveData:strUUID withIdentifier:@"com.duotePet.car.charlie"];
    }
    
    return strUUID;
    
}

@end

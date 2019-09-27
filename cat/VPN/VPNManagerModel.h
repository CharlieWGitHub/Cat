//
//  VPNManagerModel.h
//  cat
//
//  Created by 王成龙 on 2019/9/26.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VPNManagerModel : NSObject

@property (nonatomic, copy) NSString *tunnelBundleId;

@property (nonatomic, copy) NSString *serverAddress;

/**************** Base network setting  *********************************/

@property (nonatomic, copy) NSString *serverPort;
@property (nonatomic, copy) NSString *mtu;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *subnet;
@property (nonatomic, copy) NSString *dns;

- (void)configureInfoWithTunnelBundleId:(NSString *)tunnelBundleId
                          serverAddress:(NSString *)serverAddress
                             serverPort:(NSString *)serverPort
                                    mtu:(NSString *)mtu
                                     ip:(NSString *)ip
                                 subnet:(NSString *)subnet
                                    dns:(NSString *)dns;
@end

NS_ASSUME_NONNULL_END

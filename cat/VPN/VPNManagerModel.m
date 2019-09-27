//
//  VPNManagerModel.m
//  cat
//
//  Created by 王成龙 on 2019/9/26.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "VPNManagerModel.h"

@implementation VPNManagerModel

- (void)configureInfoWithTunnelBundleId:(NSString *)tunnelBundleId serverAddress:(NSString *)serverAddress serverPort:(NSString *)serverPort mtu:(NSString *)mtu ip:(NSString *)ip subnet:(NSString *)subnet dns:(NSString *)dns
{
    self.tunnelBundleId = tunnelBundleId;
    self.serverAddress = serverAddress;
    self.serverPort = serverPort;
    self.mtu = mtu;
    self.ip = ip;
    self.subnet = subnet;
    self.dns = dns;
}
@end

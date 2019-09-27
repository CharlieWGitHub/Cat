//
//  PacketTunnelProvider.m
//  catVpn
//
//  Created by 王成龙 on 2019/9/26.
//Copyright © 2019 Charlie. All rights reserved.
//

#import "PacketTunnelProvider.h"
//#include "log4cplus.h"

// 解析域名导入库
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>


#define XDX_NET_MTU 1400
#define XDX_NET_REMOTEADDRESS "222.222.222.222"
#define XDX_NET_SUBNETMASKS "255.255.255.255"
#define XDX_NET_DNS "223.5.5.5"
#define XDX_LOCAL_ADDRESS "127.0.0.1"
#define XDX_NET_TUNNEL_IPADDRESS "10.10.10.10"

@interface PacketTunnelProvider ()
@property NWTCPConnection *connection;
@property (strong) void (^pendingStartCompletion)(NSError *);
@end

@implementation PacketTunnelProvider
//建立
- (void)startTunnelWithOptions:(NSDictionary *)options completionHandler:(void (^)(NSError *))completionHandler
{
    NSLog(@"XDXPacketTunnelManager - Start Tunel !");
    //    NSString *remoteAddress = [self queryIpWithDomain:@"www.baidu.com"];
    NEPacketTunnelNetworkSettings *tunnelNetworkSettings = [[NEPacketTunnelNetworkSettings alloc] initWithTunnelRemoteAddress:@XDX_NET_REMOTEADDRESS];
    tunnelNetworkSettings.MTU = [NSNumber numberWithInteger:XDX_NET_MTU];

    //    tunnelNetworkSettings.IPv6Settings = [[NEIPv6Settings alloc]initWithAddresses:[NSArray arrayWithObjects:@"", nil] networkPrefixLengths:[NSArray arrayWithObjects:@"", nil]];

    tunnelNetworkSettings.IPv4Settings = [[NEIPv4Settings alloc] initWithAddresses:[NSArray arrayWithObjects:@XDX_NET_TUNNEL_IPADDRESS, nil] subnetMasks:[NSArray arrayWithObjects:@XDX_NET_SUBNETMASKS, nil]];

    tunnelNetworkSettings.IPv4Settings.includedRoutes = @[ [NEIPv4Route defaultRoute] ];
    // 此处不可随意设置，可根据真实情况设置
    //    NEIPv4Route *excludeRoute = [[NEIPv4Route alloc] initWithDestinationAddress:@"10.12.23.90" subnetMask:@"255.255.255.255"];
    //    tunnelNetworkSettings.IPv4Settings.excludedRoutes = @[excludeRoute];

    [self setTunnelNetworkSettings:tunnelNetworkSettings
                 completionHandler:^(NSError *_Nullable error) {
                   if (error == nil) {
                       NSLog(@"XDXPacketTunnelManager - Start Tunel Success !");
                       completionHandler(nil);
                   }
                   else {
                       NSLog(@"XDXPacketTunnelManager - Start Tunel Failed - %s !", error.debugDescription.UTF8String);
                       completionHandler(error);
                       return;
                   }
                 }];

    [self readPakcets];
}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"state"]) {
//        NWTCPConnection *conn = (NWTCPConnection *)object;
//        if (conn.state == NWTCPConnectionStateConnected) {
//            NWHostEndpoint *ra = (NWHostEndpoint *)conn.remoteAddress;
//            __weak PacketTunnelProvider *weakself = self;
//            [self setTunnelNetworkSettings:[[NEPacketTunnelNetworkSettings alloc] initWithTunnelRemoteAddress:ra.hostname] completionHandler:^(NSError *error) {
//                if (error == nil) {
//                    [weakself addObserver:weakself forKeyPath:@"defaultPath" options:NSKeyValueObservingOptionInitial context:nil];
//                    [weakself.packetFlow readPacketsWithCompletionHandler:^(NSArray<NSData *> *packets, NSArray<NSNumber *> *protocols) {
//                        // Add code here to deal with packets, and call readPacketsWithCompletionHandler again when ready for more.
//                    }];
//                    [conn readMinimumLength:0 maximumLength:8192 completionHandler:^(NSData *data, NSError *error) {
//                        // Add code here to parse packets from the data, call [self.packetFlow writePackets] with the result
//                    }];
//                }
//                if (weakself.pendingStartCompletion != nil) {
//                    weakself.pendingStartCompletion(nil);
//                    weakself.pendingStartCompletion = nil;
//                }
//            }];
//        } else if (conn.state == NWTCPConnectionStateDisconnected) {
//            NSError *error = [NSError errorWithDomain:@"PacketTunnelProviderDomain" code:-1 userInfo:@{ NSLocalizedDescriptionKey: @"Connection closed by server" }];
//            if (self.pendingStartCompletion != nil) {
//                self.pendingStartCompletion(error);
//                self.pendingStartCompletion = nil;
//            } else {
//                [self cancelTunnelWithError:error];
//            }
//            [conn cancel];
//        } else if (conn.state == NWTCPConnectionStateCancelled) {
//            [self removeObserver:self forKeyPath:@"defaultPath"];
//            [conn removeObserver:self forKeyPath:@"state"];
//            self.connection = nil;
//        }
//    } else if ([keyPath isEqualToString:@"defaultPath"]) {
//        // Add code here to deal with changes to the network
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//
//}

- (void)readPakcets
{
    __weak PacketTunnelProvider *weakSelf = self;
    [self.packetFlow readPacketsWithCompletionHandler:^(NSArray<NSData *> *_Nonnull packets, NSArray<NSNumber *> *_Nonnull protocols) {
      for (NSData *packet in packets) {
          // log4cplus_debug("XDXVPNManager", "Read Packet - %s",[NSString stringWithFormat:@"%@",packet].UTF8String);
          //            __typeof__(self) strongSelf = weakSelf;
          // TODO ...

          NSLog(@"XDX : read packet - %@", packet);
      }
      [weakSelf readPakcets];
    }];
}


- (NSString *)queryIpWithDomain:(NSString *)domain
{
    struct hostent *hs;
    struct sockaddr_in server;
    if ((hs = gethostbyname([domain UTF8String])) != NULL) {
        server.sin_addr = *((struct in_addr *)hs->h_addr_list[0]);
        return [NSString stringWithUTF8String:inet_ntoa(server.sin_addr)];
    }

    return nil;
}
//断开
- (void)stopTunnelWithReason:(NEProviderStopReason)reason completionHandler:(void (^)(void))completionHandler
{
    // Add code here to start the process of stopping the tunnel
    [self.connection cancel];
    completionHandler();
}

- (void)handleAppMessage:(NSData *)messageData completionHandler:(void (^)(NSData *))completionHandler
{
    // Add code here to handle the message
    if (completionHandler != nil) {
        completionHandler(messageData);
    }
}

- (void)sleepWithCompletionHandler:(void (^)(void))completionHandler
{
    // Add code here to get ready to sleep
    completionHandler();
}

- (void)wake
{
    // Add code here to wake up
}

@end

//
//  VPNManager.h
//  cat
//
//  Created by 王成龙 on 2019/9/26.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VPNManagerModel, NETunnelProviderManager;
NS_ASSUME_NONNULL_BEGIN

@protocol VPNManagerDelegate <NSObject>

- (void)loadFromPreferencesComplete;

@end


@interface VPNManager : NSObject

@property (nonatomic, strong) NETunnelProviderManager *vpnManager;


@property (nonatomic, weak) id<VPNManagerDelegate> delegate;

- (void)configMangerWithModel:(VPNManagerModel *)model;

- (BOOL)startVPN;

- (BOOL)stopVPN;

@end

NS_ASSUME_NONNULL_END

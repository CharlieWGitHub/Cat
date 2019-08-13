//
//  LoginHandle.h
//  cat
//
//  Created by 王成龙 on 2019/8/13.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "HTTPRequestHandle.h"
#import "HTTPRequestManager.h"
#import "NetWorkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginHandle : HTTPRequestHandle

+ (void)loadWithName:(NSString *)name passworld:(NSString *)passworld success:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END

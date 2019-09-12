//
//  CCProxy.m
//  cat
//
//  Created by 王成龙 on 2019/9/10.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "CCProxy.h"
#import <objc/runtime.h>

@implementation CCProxy

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}
@end

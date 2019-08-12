//
//  NotificationService.m
//  catPushServer
//
//  Created by 王成龙 on 2019/8/7.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "NotificationService.h"

#import "JPushNotificationExtensionService.h"

@interface NotificationService () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

/**
 收到通知处理通知
-有30秒的时间-处理-图片或者视频 保存本地- 包装为一个UNNotificationAttachment扔给通知
 @param request 通知信息
 @param contentHandler 处理
 */
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [notificationServer]", self.bestAttemptContent.title];
//取出来图片
    NSString * attachmentPath = self.bestAttemptContent.userInfo[@"my-attachment"];

    //if exist
    if (attachmentPath) {
        //download
        NSURL *fileURL = [NSURL URLWithString:attachmentPath];
        [self downloadAndSave:fileURL handler:^(NSString *localPath) {
                        if (localPath) {
                            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"myAttachment" URL:[NSURL fileURLWithPath:localPath] options:nil error:nil];
                            self.bestAttemptContent.attachments = @[ attachment ];
                        }
                        [self apnsDeliverWith:request];
                      }];
    }else{
        [self apnsDeliverWith:request];
    }
    //    self.contentHandler(self.bestAttemptContent);
}
- (void)downloadAndSave:(NSURL *)fileURL handler:(void (^)(NSString *))handler {

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:fileURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                  NSString *localPath = nil;
                                                  if (!error) {
                                                      NSString *localURL = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), fileURL.lastPathComponent];
                                                      if ([[NSFileManager defaultManager] moveItemAtPath:location.path toPath:localURL error:nil]) {
                                                          localPath = localURL;
                                                      }
                                                  }
                                                  handler(localPath);
                                                }];
    [task resume];
    
}

- (void)apnsDeliverWith:(UNNotificationRequest *)request {

    //please invoke this func on release version
    //[JPushNotificationExtensionService setLogOff];

    //service extension sdk
    //upload to calculate delivery rate
    [JPushNotificationExtensionService jpushSetAppkey:@"ce6491e8a1be14c7b0a62cb7"];
    [JPushNotificationExtensionService jpushReceiveNotificationRequest:request with:^ {
                                                                    NSLog(@"apns upload success");
                                                                    self.contentHandler(self.bestAttemptContent);
                                                                  }];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}


@end

//
//  AppDelegate.m
//  cat
//
//  Created by 王成龙 on 2019/8/7.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "AppDelegate.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
#import "FLTabBarViewController.h"
#import "WelcomeViewController.h"
#import "GestureLockView.h"
#import "KeychainManager.h"

// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>

#endif
#define JPUSHKEY @"ce6491e8a1be14c7b0a62cb7"

@interface AppDelegate () <JPUSHRegisterDelegate, UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    FLTabBarViewController *main = [[FLTabBarViewController alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:CatWelcomeIsLaunchDefaultKey] != YES) {
        NSArray *imgArr = @[ @"welcome1", @"welcome2", @"welcome3", @"welcome1" ];
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] initWithImageNameArray:imgArr rootViewController:main];
        self.window.rootViewController = welcomeVC;
    }
    else {
        NSString *passStr = [KeychainManager keyChainReadData:@"pass"]; //      存在
        if (passStr.length > 0) {
            GestureLockView *gesture = [[GestureLockView alloc] init];
            gesture.gestureType = 1;
            self.window.rootViewController = gesture;
        }
        else {
            //      不存在
            self.window.rootViewController = main;
        }
    }
    [self.window makeKeyAndVisible];

    [self replayJPUSHNotification:application launchOption:launchOptions];
    [self replayPushNotification:application];
    //  程序没有起动的时候点通知进来
    NSDictionary *pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    //    [self makePush];
    NSLog(@"pushNotificationKey--%@", pushNotificationKey);
    [self makePush:pushNotificationKey];
    return YES;
}
- (void)makePush:(NSDictionary *)pushDic
{
    if (pushDic) {
    }
}

#pragma mark 注册极光推送
- (void)replayJPUSHNotification:(UIApplication *)application launchOption:(NSDictionary *)launchOptions
{
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound | JPAuthorizationOptionProvidesAppNotificationSettings;
    }
    else {
        entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPUSHKEY
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
}
#pragma mark 申请通知权限
- (void)replayPushNotification:(UIApplication *)application
{

    if (@available(iOS 10.0, *)) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center setNotificationCategories:[NSSet setWithObjects:[self createCatrgory], nil]];
        [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound
                              completionHandler:^(BOOL granted, NSError *_Nullable error) {
                                if (granted == YES && !error) {
                                    NSLog(@"授权成功"); //用户点击允许
                                }
                                else {
                                    NSLog(@"授权失败"); //用户点击允许
                                }
                              }];

        [[UIApplication sharedApplication] registerForRemoteNotifications];

        //获取权限设置，用户点击了统一还是不同意都可以获取
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *_Nonnull settings) {
          NSLog(@"=====%@", settings);
        }];
    }
}
#pragma mark - 创建通知分类（交互按钮）

- (UNNotificationCategory *)createCatrgory
{
    //文本交互(iOS10之后支持对通知的文本交互)
    /**options
     UNNotificationActionOptionAuthenticationRequired  用于文本
     UNNotificationActionOptionForeground  前台模式，进入APP
     UNNotificationActionOptionDestructive  销毁模式，不进入APP
     */
    UNTextInputNotificationAction *textInputAction = [UNTextInputNotificationAction actionWithIdentifier:@"action_input" title:@"请输入信息" options:UNNotificationActionOptionAuthenticationRequired textInputButtonTitle:@"输入" textInputPlaceholder:@"还有多少话要说……"];

    //点赞
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action_like" title:@"点赞" options:UNNotificationActionOptionForeground];

    //不打开应用按钮
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action_close" title:@"关闭" options:UNNotificationActionOptionDestructive];

    //创建分类
    /**
     Identifier:分类的标识符，通知可以添加不同类型的分类交互按钮
     actions：交互按钮
     intentIdentifiers：分类内部标识符  没什么用 一般为空就行
     options:通知的参数   UNNotificationCategoryOptionCustomDismissAction:自定义交互按钮   UNNotificationCategoryOptionAllowInCarPlay:车载交互
     */
    //下面的Identifier 需与 NotificationContent的info.plist 文件中所配置的 UNNotificationExtensionCategory 一致，
    //本示例中为“myNotificationCategory”

    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"myNotificationCategory" actions:@[ textInputAction, action1, action2 ] intentIdentifiers:@[ textInputAction.identifier, action1.identifier, action2.identifier ] options:UNNotificationCategoryOptionCustomDismissAction];

    return category;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(nonnull UNNotificationResponse *)response withCompletionHandler:(nonnull void (^)(void))completionHandler
{

    //  根据identifer判断按钮类型，如果是textInput则获取输入的文字
    if ([response.actionIdentifier isEqualToString:@"action_input"]) {
        //  获取文本响应
        UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse *)response;
        NSLog(@"输入的内容为：%@", textResponse.userText);
    }
    NSLog(@"actionIdentifier----%@", response.actionIdentifier);
    //处理其他事件
    completionHandler();
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 注册deviceToken
- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //Optional
    CCLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification
{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
        CCLog(@"here%@", notification.request.content.userInfo);
    }
    else {
        //从通知设置界面进入应用
        CCLog(@"here here");
        CCLog(@"=====%@", notification.request.content.userInfo);
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
{
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    CCLog(@"iOS 10 Support=%@", userInfo);
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    CCLog(@"iOS 10 Support=%@", userInfo);

    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(); // 系统要求执行这个方法
}
//活跃状态收到通知（未杀死APP）
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Required, iOS 7 Support

    CCLog(@"进来了进来了：%@", userInfo);

    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

@end

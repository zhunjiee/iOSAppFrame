//
//  AppDelegate.m
//  CheTuoTuo
//
//  Created by Houge on 2021/1/6.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseWebViewController.h"
#import <ViewDeck.h>
#import "HomeViewController.h"
#import "MenuViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate () <IIViewDeckControllerDelegate, JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootViewControllerWithFrameType:FrameTypeViewDeck];
    [self setupThirdFrameworks];
    [self registerJPushServiceWithOption:launchOptions];
    [self skipToAdLaunchView];
    return YES;
}

/// 设置根控制器
- (void)setupRootViewControllerWithFrameType:(FrameType)type {
    UIViewController *rootController;
    
    if (type == FrameTypeTabBar) {
        BaseTabBarController *tabBarController = [[BaseTabBarController alloc] init];
        rootController = tabBarController;
        
    } else if (type == FrameTypeViewDeck) {
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
        
        MenuViewController *menuVC = [[MenuViewController alloc] init];
        menuVC.homeVC = homeVC;
        
        IIViewDeckController *deckController = [[IIViewDeckController alloc] initWithCenterViewController:homeNav leftViewController:menuVC];
        deckController.delegate = self;
        homeVC.viewDeckVC = deckController;
        menuVC.viewDeckVC = deckController;
        
        rootController = deckController;
        
    } else if (type == FrameTypeMMDrawer) {
        
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootController;
    [self.window makeKeyAndVisible];
}

/// 三方库设置
- (void)setupThirdFrameworks {
    // HUD蒙版
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    // 键盘管理
    IQKeyboardManager.sharedManager.enable = YES;
    
    // 百度地图
    [self initBaiduMap];
}

#pragma mark - 百度地图
/// 初始化百度地图和百度导航
- (void)initBaiduMap {
    // 百度地图
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:MapKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"map manager start failed!");
    }

}

#pragma mark - AD广告页
/// 跳转到广告页
- (void)skipToAdLaunchView {
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchScreen];
    [XHLaunchAd setWaitDataDuration:3];
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [[XHLaunchImageAdConfiguration alloc] init];
    imageAdconfiguration.duration = 3;
    imageAdconfiguration.frame = self.window.bounds;
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//    imageAdconfiguration.imageNameOrURLString = @"https://gitee.com/zhunjiee/picture-bed/raw/master/iOS/ad_image.png";
    // 注：加载本地图片不要放在Assets中
    imageAdconfiguration.imageNameOrURLString = @"ad_image.png";
    //为了展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
    imageAdconfiguration.imageOption = XHLaunchAdImageCacheInBackground;
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.baidu.com";
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
    imageAdconfiguration.showFinishAnimateTime = 0.2;
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

/// 广告点击事件代理方法
- (BOOL)xhLaunchAd:(XHLaunchAd *)launchAd clickAtOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint {
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel == nil) return NO;
    
    NSString *urlString = (NSString *)openModel;
    //此处跳转页面
    BaseWebViewController *webVC = [[BaseWebViewController alloc] init];
    webVC.urlStr = urlString;
    webVC.title = @"广告";
    //此处不要直接取keyWindow
    BaseTabBarController *rootVC = (BaseTabBarController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    BaseNavigationController *nav = rootVC.viewControllers.firstObject;
    [nav pushViewController:webVC animated:YES];
    return YES; //YES移除广告,NO不移除广告
}


#pragma mark - 极光推送

/// 注册极光推送
- (void)registerJPushServiceWithOption:(NSDictionary *)launchOptions {
    // 注册APNs通知,后台时显示
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey channel:@"App Store" apsForProduction:YES advertisingIdentifier:nil];
    
    // 注册自定义消息,前台时显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

/// 接收APNS推送通知消息
- (void)getAPNsContent:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge 数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得 Extras 字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中 Extras 字段，key 是自己定义的
    NSLog(@"content = [%@], badge = [%ld], sound = [%@], customize field = [%@]", content, (long)badge, sound, customizeField1);
    
    // 设置通知红点个数
    if (badge > 0) {
        // 设置本地通知个数
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge - 1];
        // 修改服务器上badge的值
        [JPUSHService setBadge:badge - 1];
    }
}

/// 接收自定义消息, APP前台显示
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSString *messageID = [userInfo valueForKey:@"_j_msgid"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSLog(@"messageID: %@", messageID);
    NSLog(@"content: %@", content);
    NSLog(@"extras: %@", extras);
}


#pragma mark- JPUSHRegisterDelegate

/// 检测通知授权结果的回调
- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    if (status == JPAuthorizationStatusDenied) {
        NSLog(@"用户关闭了通知");
    }
}

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
        [self getAPNsContent:userInfo];
        NSLog(@"从通知界面直接进入应用");
    } else {
        //从通知设置界面进入应用
        [self getAPNsContent:userInfo];
        NSLog(@"从通知设置界面进入应用");
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self getAPNsContent:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self getAPNsContent:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webUrl = userActivity.webpageURL;
        if ([webUrl.host isEqualToString:@"www.vvtok.com"] || [webUrl.host isEqualToString:@"vvtok.com"]) {
            
        }
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

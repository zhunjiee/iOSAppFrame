//
//  SceneDelegate.m
//  CheTuoTuo
//
//  Created by Houge on 2021/1/6.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import <ViewDeck.h>
#import "HomeViewController.h"
#import "MenuViewController.h"

@interface SceneDelegate () <IIViewDeckControllerDelegate>

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    // 设置根控制器
    if (scene) {
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
        
        MenuViewController *menuVC = [[MenuViewController alloc] init];
        
        IIViewDeckController *rootController = [[IIViewDeckController alloc] initWithCenterViewController:homeNav leftViewController:menuVC];
        rootController.delegate = self;
        homeVC.viewDeckVC = rootController;
        menuVC.viewDeckVC = rootController;
        
        UIWindowScene *windowScence = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScence];
        self.window.frame = windowScence.coordinateSpace.bounds;
        self.window.rootViewController = rootController;
        [self.window makeKeyAndVisible];
    }
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
        BaseNavigationController *menuNav = [[BaseNavigationController alloc] initWithRootViewController:menuVC];
        
        IIViewDeckController *deckController = [[IIViewDeckController alloc] initWithCenterViewController:homeNav leftViewController:menuNav];
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


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end

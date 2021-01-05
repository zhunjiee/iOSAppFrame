//
//  DrawerViewController.m
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "DrawerViewController.h"
#import "BaseNavigationController.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface DrawerViewController ()
@property (strong, nonatomic) UIView *mainView;     // 主视图
@property (strong, nonatomic) UIView *leftView;     // 左视图
@property (strong, nonatomic) UIView *rightView;    // 右视图
@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    
    // 添加手势
    [self addGestureRecognizer];
    
    // KVO监听frame的改变
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)addChildViewControllers {
    if (self.type == DrawerTypeLeft) {
        LeftViewController *leftVC = [[LeftViewController alloc] init];
        [self addChildViewController:leftVC];
        leftVC.view.frame = self.view.bounds;
        [self.view addSubview:leftVC.view];
        self.leftView = leftVC.view;
        
    } else if (self.type == DrawerTypeRight) {
        RightViewController *rightVC = [[RightViewController alloc] init];
        [self addChildViewController:rightVC];
        rightVC.view.frame = self.view.bounds;
        [self.view addSubview:rightVC.view];
        self.rightView = rightVC.view;
        
    } else {
        LeftViewController *leftVC = [[LeftViewController alloc] init];
        [self addChildViewController:leftVC];
        leftVC.view.frame = self.view.bounds;
        [self.view addSubview:leftVC.view];
        self.leftView = leftVC.view;
        
        RightViewController *rightVC = [[RightViewController alloc] init];
        [self addChildViewController:rightVC];
        rightVC.view.frame = self.view.bounds;
        [self.view addSubview:rightVC.view];
        self.rightView = rightVC.view;
    }
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.view.frame = CGRectMake(0, 0, ScreenWidth, ControllerViewNoNavBarHeight);
    mainVC.mainVcMenuNavBtnDidClick = ^(UIButton * _Nonnull button) {
        [self mainViewScrollingIsRightDrawer:NO];
    };
    mainVC.mainVcMessageNavBtnDidClick = ^(UIButton * _Nonnull button) {
        [self mainViewScrollingIsRightDrawer:YES];
    };
    BaseNavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    [self addChildViewController:mainNav];
    [self.view addSubview:mainNav.view];
    self.mainView = mainNav.view;
}

/// 添加手势
- (void)addGestureRecognizer {
    // 添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    // 添加单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - 事件监听
/// 监听到frame有新值时就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (self.mainView.frame.origin.x > 0) {
        self.rightView.hidden = YES;
    }else if (self.mainView.frame.origin.x < 0){
        self.rightView.hidden = NO;
    }
}

/// 点击屏幕时复位
- (void)tap:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}

#define targetRightX 240
#define targetLeftX -180
- (void)pan:(UIPanGestureRecognizer *)pan {
    // 获取手指偏移量
    CGFloat offsetX = [pan translationInView:self.mainView].x;
    
    if (self.type == DrawerTypeLeft && (self.mainView.x + offsetX < 0)) {
        return;
    }
    if (self.type == DrawerTypeRight && (self.mainView.x + offsetX > 0)) {
        return;
    }
    
    // 修改mainView的frame
//    self.mainView.frame = [self frameWithOffsetX:offsetX];
    self.mainView.x += offsetX;
    
    // 复位
    [pan setTranslation:CGPointZero inView:self.mainView];
    
    // 手指抬起的时候定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        CGFloat target = 0;
        
        if (self.mainView.frame.origin.x > ScreenWidth * 0.5) {
            target = targetRightX;
            
        } else if (CGRectGetMaxX(self.mainView.frame) < ScreenWidth * 0.5) {
            target = targetLeftX;
        }
        
        // 计算偏移量
        CGFloat offsetX = target - self.mainView.frame.origin.x;
        // 通过动画定位到指定位置
        [UIView animateWithDuration:0.25 animations:^{
//            self.mainView.frame = [self frameWithOffsetX:offsetX];
            self.mainView.x += offsetX;
        }];
    }
}

/// 点击导航栏-自动滚动到相应位置
- (void)mainViewScrollingIsRightDrawer:(BOOL)isRightDrawer {
    CGFloat target = 0;
    
    if (isRightDrawer) {
        target = targetLeftX;
    } else {
        target = targetRightX;
    }
    
    // 计算偏移量
    CGFloat offsetX = target - self.mainView.frame.origin.x;
    // 通过动画定位到指定位置
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.x += offsetX;
    }];
}

#define maxY 100
/// 计算 缩放效果 frame
- (CGRect)frameWithOffsetX:(CGFloat)offsetX{
    CGRect tempFrame = self.mainView.frame;
    
    CGFloat x = tempFrame.origin.x += offsetX;
    
    // 根据x计算新的frame
    CGFloat y = fabs((x / ScreenWidth) * maxY);
    
    CGFloat h = ScreenHeight - 2 * y;
    
    CGFloat scale = h / ScreenHeight;
    
    CGFloat w = scale * ScreenWidth;
    
    return CGRectMake(x, y, w, h);
}

@end

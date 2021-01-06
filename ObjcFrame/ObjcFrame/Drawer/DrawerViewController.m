//
//  DrawerViewController.m
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "DrawerViewController.h"
#import "BaseNavigationController.h"

#define targetRightX 240    // 左侧视图宽度
#define targetLeftX -180    // 右侧视图宽度
#define maxY 100            // 影响缩放

@interface DrawerViewController ()
@property (strong, nonatomic) UIView *mainView;     // 主视图
@property (strong, nonatomic) UIView *leftView;     // 左视图
@property (strong, nonatomic) UIView *rightView;    // 右视图
@end

@implementation DrawerViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    
    // 添加手势
    [self addGestureRecognizer];
    
    // KVO监听frame的改变
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)addChildViewControllers {
    // 左侧菜单控制器
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    leftVC.view.frame = self.view.bounds;
    leftVC.leftMenuViewClickBlock = ^(NSInteger index) {
        NSLog(@"选中第%ld行", (long)index);
        [self resetMainViewFrame];
    };
    // 右侧消息控制器
    RightViewController *rightVC = [[RightViewController alloc] init];
    rightVC.view.frame = self.view.bounds;
    
    if (self.type == DrawerTypeLeft) {
        [self addChildViewController:leftVC];
        [self.view addSubview:leftVC.view];
        self.leftView = leftVC.view;
        
    } else if (self.type == DrawerTypeRight) {
        [self addChildViewController:rightVC];
        [self.view addSubview:rightVC.view];
        self.rightView = rightVC.view;
        
    } else {
        [self addChildViewController:leftVC];
        [self.view addSubview:leftVC.view];
        self.leftView = leftVC.view;

        [self addChildViewController:rightVC];
        [self.view addSubview:rightVC.view];
        self.rightView = rightVC.view;
    }
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.view.frame = CGRectMake(0, 0, ScreenWidth, ControllerViewNoNavBarHeight);
    mainVC.type = self.type;
    mainVC.leftNavImageName = self.leftNavImageName;
    mainVC.rightNavImageName = self.rightNavImageName;
    // 导航栏点击事件
    mainVC.mainVcMenuNavBtnClickBlock = ^(UIButton * _Nonnull button) {
        [self mainViewAnimatingWithIsRightDrawer:NO];
    };
    mainVC.mainVcMessageNavBtnClickBlock = ^(UIButton * _Nonnull button) {
        [self mainViewAnimatingWithIsRightDrawer:YES];
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
    [self.mainView addGestureRecognizer:tap];
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
    [self resetMainViewFrame];
}

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

#pragma mark - 私有方法
/// 视图复位
- (void)resetMainViewFrame {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}

/// 点击导航栏按钮 - 自动滚动到相应位置
- (void)mainViewAnimatingWithIsRightDrawer:(BOOL)isRightDrawer {
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

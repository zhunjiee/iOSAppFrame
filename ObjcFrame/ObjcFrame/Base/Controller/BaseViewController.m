//
//  BaseViewController.m
//  MengTianXIa
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = BW_WHITE_COLOR;
    // view 不被导航栏遮挡
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end

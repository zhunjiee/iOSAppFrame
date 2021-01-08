//
//  BaseCollectionViewController.m
//  ObjcFrame
//
//  Created by zl on 2019/10/23.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    // view 不被导航栏遮挡
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.collectionView.backgroundColor =  BACKGROUND_COLOR;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

@end

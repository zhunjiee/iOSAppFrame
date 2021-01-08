//
//  MenuViewController.m
//  CheTuoTuo
//
//  Created by Houge on 2021/1/7.
//

#import "MenuViewController.h"
#import "MemberViewController.h"
#import "NewsViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
static NSString * const CellReuseId = @"CellReuseId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self registerTableViewCell];
}

- (void)initView {
    // 设置侧边栏的显示宽度
    self.preferredContentSize = CGSizeMake(ScreenWidth - 100.f, ScreenHeight);
}

- (void)registerTableViewCell {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseId];
}


#pragma mark - UITbaleViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseId];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 关闭侧边栏
    [self.viewDeckVC closeSide:YES];
    
    // 注:界面跳转时通过self.homeVC的导航栏跳转
    switch (indexPath.row) {
        case 0:
        {
            MemberViewController *vc = [[MemberViewController alloc] init];
            [self.homeVC.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 1:
        {
            NewsViewController *vc = [[NewsViewController alloc] init];
            [self.homeVC.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end

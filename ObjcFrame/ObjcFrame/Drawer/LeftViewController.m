//
//  LeftViewController.m
//  ObjcFrame
//
//  Created by Houge on 2021/1/5.
//  Copyright © 2021 ZHUNJIEE. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController
static NSString * const CellReusedID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationBar];
    [self registerTableViewCell];
}

- (void)setupNavigationBar {
    self.title = @"消息";
}

- (void)registerTableViewCell {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReusedID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReusedID];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.leftMenuViewClickBlock) {
        self.leftMenuViewClickBlock(indexPath.row);
    }
}

@end

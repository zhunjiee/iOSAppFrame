//
//  HomePublishView.m
//  CheTuoTuo
//
//  Created by Houge on 2021/1/7.
//

#import "HomePublishView.h"

@interface HomePublishView ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;           // 金额
@property (weak, nonatomic) IBOutlet RightImageButton *detailBtn;   // 明细
@property (weak, nonatomic) IBOutlet UITextField *tipTextLabel;     // 小费
@property (weak, nonatomic) IBOutlet UIButton *discountBtn;       // 优惠券
@property (weak, nonatomic) IBOutlet UIView *payWaySelectedBgcView; // 支付方式选中背景视图
@property (weak, nonatomic) IBOutlet UIButton *earnestBtn;          // 付定金
@property (weak, nonatomic) IBOutlet UIButton *allMoneyBtn;         // 全款
@property (weak, nonatomic) IBOutlet UIButton *freightBtn;          // 到付
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *licenseBtn;
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
/// 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payWayBgcLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discountBtnCenterX;

@property (strong, nonatomic) UIButton *selectedPayWayBtn;          // 选中付款方式
@end

@implementation HomePublishView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 选中付款方式按钮
    self.selectedPayWayBtn = self.freightBtn;
    // 添加背景渐变色
    [self.payWaySelectedBgcView insertGradientLayer];
    [self.publishBtn insertGradientLayer];
    // 修改约束
    self.discountBtnCenterX.constant = ScreenWidth < 375.f ? 40 : 10;
}

#pragma mark - 事件监听
/// 改变支付方式
- (IBAction)changePayWay:(UIButton *)sender {
    NSInteger index = sender.tag;
    
    self.selectedPayWayBtn = sender;
    self.payWayBgcLeft.constant = index * 50;
}
/// 同意用户协议
- (IBAction)agreeBtnDidClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
/// 用户协议
- (IBAction)userLicenseBtnDidClick:(UIButton *)sender {
}
/// 确认发布
- (IBAction)confirmPublishBtnDidClick:(UIButton *)sender {
    if (!self.agreeBtn.isSelected) {
        [SVProgressHUD showInfoWithStatus:@"请先同意《车拖拖用户协议》"];
        return;
    }
}
/// 明细
- (IBAction)detailBtnDidClick:(UIButton *)sender {
}
/// 优惠券
- (IBAction)discountBtnDidClick:(UIButton *)sender {
}

@end

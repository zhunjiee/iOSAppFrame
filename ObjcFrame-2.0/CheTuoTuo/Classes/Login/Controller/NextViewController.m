//
//  NextViewController.m
//  CheTuoTuo
//
//  Created by Qzhang on 2021/1/7.
//

#import "NextViewController.h"
#import "ForgetViewController.h"
#import "ConstantHeader.h"

@interface NextViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pswText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submitBtn insertGradientLayer];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)submitClick:(id)sender {
    
}
- (IBAction)codeClick:(id)sender {
    ForgetViewController *vc= [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetClick:(id)sender {
    ForgetViewController *vc= [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)fuwuClick:(id)sender {
}
- (IBAction)yinsiClick:(id)sender {
}


@end

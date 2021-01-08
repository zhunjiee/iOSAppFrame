//
//  LoginViewController.m
//  CheTuoTuo
//
//  Created by Qzhang on 2021/1/7.
//

#import "LoginViewController.h"
#import "NextViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nextBtn insertGradientLayer];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)nextClick:(id)sender {
    NextViewController *vc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)fuwuClick:(id)sender {
}
- (IBAction)yinsiClick:(id)sender {
}

@end

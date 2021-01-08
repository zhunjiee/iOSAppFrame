//
//  ForgetViewController.m
//  CheTuoTuo
//
//  Created by Qzhang on 2021/1/7.
//

#import "ForgetViewController.h"
#import "SetPswViewController.h"

@interface ForgetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submitBtn insertGradientLayer];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)codeClick:(id)sender {
}
- (IBAction)submitClick:(id)sender {
    SetPswViewController *vc= [[SetPswViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)fuwuClick:(id)sender {
}

- (IBAction)yinsiClick:(id)sender {
}
@end

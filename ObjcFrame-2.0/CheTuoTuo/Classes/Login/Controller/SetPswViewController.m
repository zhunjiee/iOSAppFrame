//
//  SetPswViewController.m
//  CheTuoTuo
//
//  Created by Qzhang on 2021/1/7.
//

#import "SetPswViewController.h"

@interface SetPswViewController ()

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *pswText;
@end

@implementation SetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submitBtn insertGradientLayer];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)submitClick:(id)sender {
}
- (IBAction)fuwuClick:(id)sender {
}
- (IBAction)xieyiClick:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

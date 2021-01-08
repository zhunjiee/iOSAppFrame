//
//  HomeLocationCell.m
//  CheTuoTuo
//
//  Created by Houge on 2021/1/8.
//

#import "HomeLocationCell.h"

@interface HomeLocationCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIView *separateLine;

@end

@implementation HomeLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setType:(HomeLocationType)type {
    _type = type;
    
    if (type == HomeLocationEnd) {
        self.iconView.image = [UIImage imageNamed:@"home_end_point_img"];
        self.locationTF.placeholder = @"选择终点";
        self.separateLine.hidden = YES;
    } else {
        self.iconView.image = [UIImage imageNamed:@"home_start_point_img"];
        self.locationTF.placeholder = @"选择起点";
        self.separateLine.hidden = NO;
    }
}

@end

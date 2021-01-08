//
//  HomeBannerCell.m
//  CheTuoTuo
//
//  Created by Houge on 2021/1/7.
//

#import "HomeBannerCell.h"

@interface HomeBannerCell ()<SDCycleScrollViewDelegate>
@property (strong, nonatomic) SDCycleScrollView *bannerScrollView;

@end

@implementation HomeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initBannerView];
    }
    return self;
}

/// 广告轮播图
- (void)initBannerView {
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(16.f, 0.0, ScreenWidth - 32.f, ScaleWidth(128.f)) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor colorWithHexString:@"#27AB39"];
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    cycleScrollView.autoScroll = YES;
    cycleScrollView.autoScrollTimeInterval = 5;
    cycleScrollView.layer.cornerRadius = 4.0;
    cycleScrollView.layer.masksToBounds = YES;
    [self addSubview:cycleScrollView];
    self.bannerScrollView = cycleScrollView;
    
    NSArray *imgArray = @[@"banner", @"banner", @"banner"];
    cycleScrollView.localizationImageNamesGroup = imgArray;
}

/// 点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

@end

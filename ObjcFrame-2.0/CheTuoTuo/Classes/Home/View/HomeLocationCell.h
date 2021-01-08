//
//  HomeLocationCell.h
//  CheTuoTuo
//
//  Created by Houge on 2021/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HomeLocationType) {
    HomeLocationStart,  // 选择起点
    HomeLocationEnd,    // 选择终点
};

@interface HomeLocationCell : UITableViewCell
@property (assign, nonatomic) HomeLocationType type;

@end

NS_ASSUME_NONNULL_END

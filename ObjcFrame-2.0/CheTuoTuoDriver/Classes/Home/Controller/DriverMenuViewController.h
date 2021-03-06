//
//  DriverMenuViewController.h
//  CheTuoTuo
//
//  Created by Houge on 2021/1/7.
//

#import "BaseViewController.h"
#import <ViewDeck.h>
#import "HomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DriverMenuViewController : BaseViewController
@property (strong, nonatomic) IIViewDeckController *viewDeckVC;
@property (strong, nonatomic) HomeViewController *homeVC;
@end

NS_ASSUME_NONNULL_END

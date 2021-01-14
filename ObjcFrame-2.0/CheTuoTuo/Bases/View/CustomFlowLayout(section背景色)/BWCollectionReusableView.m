//
//  JHCollectionReusableView.m
//  HiiN
//
//  Created by 张健华-迈动 on 2017/3/7.
//  Copyright © 2017年 huanli. All rights reserved.
//

#import "BWCollectionReusableView.h"
#import "BWCollectionViewLayoutAttributes.h"

@implementation BWCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[BWCollectionViewLayoutAttributes class]]) {
        BWCollectionViewLayoutAttributes *attr = (BWCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}
@end

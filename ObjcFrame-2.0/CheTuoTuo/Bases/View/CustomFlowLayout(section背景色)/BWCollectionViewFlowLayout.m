//
//  JHCollectionViewFlowLayout.m
//  HiiN
//
//  Created by 张健华-迈动 on 2017/3/7.
//  Copyright © 2017年 huanli. All rights reserved.
//

#import "BWCollectionViewFlowLayout.h"
#import "BWCollectionReusableView.h"
#import "BWCollectionViewLayoutAttributes.h"

NSString *const BWCollectionViewSectionBackground = @"BWCollectionViewSectionBackground";

@implementation BWCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.decorationViewAttrs = [NSMutableArray array];
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self registerClass:[BWCollectionReusableView class] forDecorationViewOfKind:BWCollectionViewSectionBackground];
}

- (void)prepareLayout
{
    [super prepareLayout];
    [self.decorationViewAttrs removeAllObjects];

    NSInteger numberOfSections = [self.collectionView numberOfSections];
    id delegate = self.collectionView.delegate;
    if (!numberOfSections || ![delegate conformsToProtocol:@protocol(BWCollectionViewDelegateFlowLayout)]) {
        return;
    }
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems <= 0) {
            continue;
        }
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:section]];
        if (!firstItem || !lastItem) {
            continue;
        }
        
        UIEdgeInsets sectionInset = [self sectionInset];

        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            UIEdgeInsets inset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            sectionInset = inset;
        }

        
        CGRect sectionFrame = CGRectUnion(firstItem.frame, lastItem.frame);
        sectionFrame.origin.x -= sectionInset.left;
        sectionFrame.origin.y -= sectionInset.top;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            sectionFrame.size.height = self.collectionView.frame.size.height;
        } else {
            sectionFrame.size.width = self.collectionView.frame.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
        }
        
        // 2、定义
        BWCollectionViewLayoutAttributes *attr = [BWCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:BWCollectionViewSectionBackground withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        attr.frame = sectionFrame;
        attr.zIndex = -1;
        
        attr.backgroundColor = [delegate collectionView:self.collectionView layout:self backgroundColorForSection:section];
        [self.decorationViewAttrs addObject:attr];
    }

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
     NSMutableArray *attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrs addObject:attr];
        }
    }
    return attrs;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:BWCollectionViewSectionBackground]) {
        return [self.decorationViewAttrs objectAtIndex:indexPath.section];
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}
@end

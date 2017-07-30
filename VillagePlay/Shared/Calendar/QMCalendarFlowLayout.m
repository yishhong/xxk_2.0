//
//  QMCalendarFlowLayout.m
//  Calendar
//
//  Created by Apricot on 16/7/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMCalendarFlowLayout.h"

@implementation QMCalendarFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
//        CGFloat width = ([UIScreen mainScreen].bounds.size.width)/7.0;
//        self.itemSize = CGSizeMake(width, 59);
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 27);
        //iOS9.0以后使用
//        self.sectionHeadersPinToVisibleBounds = YES;
    }
    return self;
}
- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
    for (NSUInteger idx=0; idx<[answer count]; idx++) {
        UICollectionViewLayoutAttributes *layoutAttributes = answer[idx];
        
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            [missingSections addIndex:layoutAttributes.indexPath.section];  // remember that we need to layout header for this section
        }
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [answer removeObjectAtIndex:idx];  // remove layout of header done by our super, we will do it right later
            idx--;
        }
    }
    
    // layout all headers needed for the rect using self code
    [missingSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (layoutAttributes != nil) {
            [answer addObject:layoutAttributes];
        }
    }];
    
    return answer;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionView * const cv = self.collectionView;
        CGPoint const contentOffset = cv.contentOffset;
        CGPoint nextHeaderOrigin = CGPointMake(INFINITY, INFINITY);
        
        if (indexPath.section+1 < [cv numberOfSections]) {
            UICollectionViewLayoutAttributes *nextHeaderAttributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section+1]];
            nextHeaderOrigin = nextHeaderAttributes.frame.origin;
        }
        
        CGRect frame = attributes.frame;
        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            frame.origin.y = MIN(MAX(contentOffset.y, frame.origin.y), nextHeaderOrigin.y - CGRectGetHeight(frame));
        }
        else { // UICollectionViewScrollDirectionHorizontal
            frame.origin.x = MIN(MAX(contentOffset.x, frame.origin.x), nextHeaderOrigin.x - CGRectGetWidth(frame));
        }
        attributes.zIndex = 1024;
        attributes.frame = frame;
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    return attributes;
}
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    return attributes;
}


- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    return YES;
}
@end

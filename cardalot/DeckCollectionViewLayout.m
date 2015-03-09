//
//  DeckCollectionViewLayout.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/8/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckCollectionViewLayout.h"
#import "DeckController.h"
#import "DeckCollectionViewDataSource.h"

#define kNumberOfItemsPerPage 8

static NSString * const cellIdentifier = @"cell";

@interface DeckCollectionViewLayout () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSDictionary *layoutInfo;

@end

@implementation DeckCollectionViewLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setup];
    }

    return self;
}

- (void)setup {
    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(160.0f, 160.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}

#pragma mark - Layout

- (void)prepareLayout {
    NSMutableDictionary *newLayoutInfo = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *cellLayoutInfo = [[NSMutableDictionary alloc] init];

    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];

    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];

        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];

            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForDeckAtIndexPath:indexPath];

            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }

    newLayoutInfo[cellIdentifier] = cellLayoutInfo;

    self.layoutInfo = newLayoutInfo;
}

#pragma mark - Private

- (CGRect)frameForDeckAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.item / self.numberOfColumns;
    NSInteger column = indexPath.item % self.numberOfColumns;
    //NSInteger row = 10;
    //NSInteger column = 2;

    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.itemSize.width);

    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);

    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);

    CGFloat originY = floor(self.itemInsets.top + (self.itemSize.height + self.interItemSpacingY) * row);

    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];

    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];

    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutInfo[cellIdentifier][indexPath];
}


- (CGSize)collectionViewContentSize {
    DeckCollectionViewDataSource *dataSource = [[DeckCollectionViewDataSource alloc] init];
    int numberOfItems = [dataSource collectionView:self.collectionView numberOfItemsInSection:0];

    CGFloat height = (numberOfItems / 2) * (self.itemSize.height + self.interItemSpacingY + 5);

    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}

@end

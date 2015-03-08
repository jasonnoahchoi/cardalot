//
//  DeckCollectionViewLayout.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/8/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckCollectionViewLayout.h"

static NSString * const cellIdentifier = @"cell";

@interface DeckCollectionViewLayout ()

@property (nonatomic, strong) NSDictionary *layoutDictionary;

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
    self.itemSize = CGSizeMake(150.0f, 150.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}

#pragma mark - Layout

- (void)prepareLayout {
    NSMutableDictionary *newLayoutDictionary = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *cellLayoutDictionary = [[NSMutableDictionary alloc] init];

    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];

    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];

        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];

            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForDeckAtIndexPath:indexPath];

            cellLayoutDictionary[indexPath] = itemAttributes;
        }
    }

    newLayoutDictionary[cellIdentifier] = cellLayoutDictionary;

    self.layoutDictionary = newLayoutDictionary;
}

#pragma mark - Private

- (CGRect)frameForDeckAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;

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
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutDictionary.count];

    [self.layoutDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
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
    return self.layoutDictionary[cellIdentifier][indexPath];
}

- (CGSize)collectionViewContentSize {
    NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
    // make sure we count another row if one is only partially filled
    if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;

    CGFloat height = self.itemInsets.top + rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY + self.itemInsets.bottom;

    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

@end

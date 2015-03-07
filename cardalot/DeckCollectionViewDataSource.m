//
//  DeckCollectionViewDataSource.m
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckCollectionViewDataSource.h"
#import "DeckController.h"

static NSString * const cellIdentifier = @"cell";

@implementation DeckCollectionViewDataSource

- (void)registerCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor cyanColor];
    NSInteger index = [DeckController sharedInstance].decks.count;
    
    if (indexPath.item == index) {
        UILabel *lastCellLabel = [UILabel new];
        lastCellLabel.text = @"#";
        lastCellLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:lastCellLabel];
        [lastCellLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(lastCellLabel);
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lastCellLabel]|" options:0 metrics:0 views:viewDictionary]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lastCellLabel]|" options:0 metrics:0 views:viewDictionary]];
    
        return cell;
    } else {
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DeckController sharedInstance].decks.count + 1;
}

@end

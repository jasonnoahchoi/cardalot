//
//  DeckCollectionViewDataSource.m
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckCollectionViewDataSource.h"
#import "DeckController.h"
#import "DeckCollectionViewCell.h"

static NSString * const cellIdentifier = @"cell";

@implementation DeckCollectionViewDataSource

- (void)registerCollectionView:(UICollectionView *)collectionView {
    [collectionView registerNib:[UINib nibWithNibName:@"DeckCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    //[collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}

- (DeckCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DeckCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //cell.contentView.backgroundColor = [UIColor colorWithHue:204.0/360 saturation:.78 brightness:.66 alpha:1.0];
    NSInteger index = [DeckController sharedInstance].decks.count;
    
    if (indexPath.item == index) {
        //cell.subjectLabel = [[UILabel alloc] init];
        [cell.subjectLabel setText:@"History"];
        cell.subjectLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:cell.subjectLabel];
      //  [lastCellLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(cell.subjectLabel);
//        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cell.subjectLabel]|" options:0 metrics:0 views:viewDictionary]];
//        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cell.subjectLabel]|" options:0 metrics:0 views:viewDictionary]];

        return cell;
    } else {
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DeckController sharedInstance].decks.count + 1;
}

@end

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
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DeckController sharedInstance].decks.count;
}

@end

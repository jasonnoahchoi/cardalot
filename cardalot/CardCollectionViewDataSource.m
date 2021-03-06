//
//  CardCollectionViewDataSource.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardCollectionViewDataSource.h"
#import "CardCollectionViewCell.h"
#import "DeckController.h"
#import "Deck.h"
#import "Card.h"
#import "CustomInputAccessoryView.h"

static NSString * const cellIdentifier = @"cell";

@implementation CardCollectionViewDataSource

- (void)registerCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.deck.cards.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    CustomInputAccessoryView *accessoryView = [[CustomInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    cell.textView.inputAccessoryView = accessoryView;
    accessoryView.delegate = cell.textView;
    
    Card *card = self.deck.cards[indexPath.item];
    cell.card = card;
    cell.textField.text = card.title;
    cell.textView.text = card.answer;
    
    return cell;
}

@end

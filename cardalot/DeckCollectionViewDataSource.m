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
#import "DeckCollectionViewController.h"
#import "Deck.h"

static NSString * const cellIdentifier = @"cell";

@implementation DeckCollectionViewDataSource

- (void)registerCollectionView:(UICollectionView *)collectionView {
    [collectionView registerNib:[UINib nibWithNibName:@"DeckCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DeckCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
        NSInteger index = [DeckController sharedInstance].decks.count;
    
    if (indexPath.item == index) {
        DeckCollectionViewController *deckVC = [[DeckCollectionViewController alloc] init];
        cell.subjectLabel.text = @"Insert Deck Name";
        cell.subjectLabel.textColor = [UIColor whiteColor];
        NSLog(@"%@", deckVC.deckTitle);
        cell.subjectLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:cell.subjectLabel];

        return cell;
    } else {
        Deck *deck = [[DeckController sharedInstance].decks objectAtIndex:indexPath.item];
        cell.subjectLabel.text = deck.nameTag;
        NSLog(@"%@", deck.nameTag);
        cell.subjectLabel.textAlignment = NSTextAlignmentCenter;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 1.5;
        longPress.cancelsTouchesInView = NO;
        [cell addGestureRecognizer:longPress];

        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DeckController sharedInstance].decks.count + 1;
}

- (void)longPress:(UILongPressGestureRecognizer *)gr {
    if (gr.state == UIGestureRecognizerStateBegan) {
        [[NSNotificationCenter defaultCenter] postNotificationName:presentAlert object:nil];
    }
}

@end

//
//  DeckCollectionViewDataSource.h
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

@import UIKit;

@class DeckCollectionViewController;

@interface DeckCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (strong, nonatomic) DeckCollectionViewController *deckCollectionVC;

- (void)registerCollectionView:(UICollectionView *)collectionView;

@end

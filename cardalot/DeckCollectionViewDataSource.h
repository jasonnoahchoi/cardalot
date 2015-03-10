//
//  DeckCollectionViewDataSource.h
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

@import UIKit;

static NSString * const presentAlert = @"deleteDeck";

@interface DeckCollectionViewDataSource : NSObject <UICollectionViewDataSource>

- (void)registerCollectionView:(UICollectionView *)collectionView;

@end

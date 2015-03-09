//
//  CardCollectionViewDataSource.h
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

@import UIKit;

@class CardCollectionViewCell;

@interface CardCollectionViewDataSource : NSObject <UICollectionViewDataSource>

- (void)registerCollectionView:(UICollectionView *)collectionView;

@end
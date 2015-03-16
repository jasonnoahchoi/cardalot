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

@interface DeckCollectionViewDataSource ()

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation DeckCollectionViewDataSource

- (void)registerCollectionView:(UICollectionView *)collectionView {
    
    self.collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"DeckCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DeckCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
        NSInteger index = [DeckController sharedInstance].decks.count;
    
    if (indexPath.item == index) {
        cell.subjectLabel.text = @"Insert Deck Name";
        cell.subjectLabel.textColor = [UIColor whiteColor];
        cell.subjectLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:cell.subjectLabel];

        return cell;
    } else {
        Deck *deck = [[DeckController sharedInstance].decks objectAtIndex:indexPath.item];
        cell.subjectLabel.text = deck.nameTag;
        cell.subjectLabel.numberOfLines = 0;
        cell.subjectLabel.lineBreakMode = NSLineBreakByWordWrapping;
        NSLog(@"%@", deck.nameTag);
        cell.subjectLabel.textAlignment = NSTextAlignmentCenter;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 1.1;
        [cell addGestureRecognizer:longPress];

        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DeckController sharedInstance].decks.count + 1;
}

- (void)longPress:(UILongPressGestureRecognizer *)gr {
    if (gr.state == UIGestureRecognizerStateBegan) {
        
        DeckCollectionViewCell *cell = (DeckCollectionViewCell *)gr.view;
        cell.closeButton.hidden = NO;

        [cell startJiggling];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to remove #?"
                                                                                 message:@"All cards inside the deck will be erased."
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Remove"
                                                            style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            Deck *deck = [DeckController sharedInstance].decks[indexPath.item];
            [[DeckController sharedInstance] removeDeck:deck];
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            
            [self.collectionView reloadData];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
            [cell stopJiggling];
            cell.closeButton.hidden = YES;
            NSLog(@"cancel");
        }]];
        [self.deckCollectionVC presentViewController:alertController animated:YES completion:nil];
        
        // [self.collectionView.visibleCells makeObjectsPerformSelector:@selector(startJiggling)];
        NSLog(@"Close Button");
    }
}

//- (void)startJiggling {
//    DeckCollectionViewCell *cell = [[DeckCollectionViewCell alloc] init];
//    CABasicAnimation *quiverAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    float startAngle = (-2) * M_PI/180.0;
//    float stopAngle = -startAngle;
//    quiverAnim.fromValue = [NSNumber numberWithFloat:startAngle];
//    quiverAnim.toValue = [NSNumber numberWithFloat:3 * stopAngle];
//    quiverAnim.autoreverses = YES;
//    quiverAnim.duration = 0.1;
//    quiverAnim.repeatCount = HUGE_VALF;
//    float timeOffset = (float)(arc4random() % 100)/100 - 0.50;
//    quiverAnim.timeOffset = timeOffset;
//    CALayer *layer = cell.layer;
//    [layer addAnimation:quiverAnim forKey:@"jiggling"];
//}
//
//- (void)stopJiggling {
//    CALayer *layer = nil;
//    [layer removeAnimationForKey:@"jiggling"];
//}

@end

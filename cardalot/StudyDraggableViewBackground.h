//
//  StudyDraggableViewBackground.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyDraggableView.h"
@class Deck;
@class Session;

@interface StudyDraggableViewBackground : UIView <StudyDraggableViewDelegate>

@property (strong, nonatomic) NSArray *topCardInDeck; //%%% the labels the cards
@property (retain, nonatomic) NSMutableArray *allCards; //%%% the labels the cards
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) Session *session;
@property (nonatomic, strong) NSArray *cards;

//methods called in DraggableView
- (void)cardSwipedLeft:(UIView *)card;
- (void)cardSwipedRight:(UIView *)card;
- (void)loadCards;
- (NSArray *)shuffleCards:(NSArray *)cards;

@end

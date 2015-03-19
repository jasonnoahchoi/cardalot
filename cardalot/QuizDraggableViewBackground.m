//
//  StudyDraggableViewBackground.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "QuizDraggableViewBackground.h"
#import "CompletionViewController.h"
#import "QuizViewController.h"
#import "DeckController.h"
#import "Card.h"
#import "Deck.h"
#import "Session.h"
#import "UIColor+Colors.h"

static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 386; //%%% height of the draggable card
static const float CARD_WIDTH = 290; //%%% width of the draggable card

@interface QuizDraggableViewBackground ()

@property (nonatomic, assign) NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
@property (nonatomic, strong) NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
@property (nonatomic, assign) NSInteger markedCorrect;

@end

@implementation QuizDraggableViewBackground

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       [super layoutSubviews];
        [self setupView];
        [self setFrameOfViewBackground];
       // self.flipped = NO;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.cornerRadius = 3;

        self.topCardInDeck = [self.deck.cards.set allObjects];
        self.loadedCards = [[NSMutableArray alloc] init];
        self.allCards = [[NSMutableArray alloc] init];
        self.cardsLoadedIndex = 0;
                //[self loadCards];
  
    }

    return self;
}

- (void)setFrameOfViewBackground {
    if ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480) {
        self.frame = CGRectMake((self.frame.size.width - 250)/2, (self.frame.size.height - 280)/2, 250, 330);
    } else if ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 568) {
        self.frame = CGRectMake((self.frame.size.width - 250)/2, (self.frame.size.height - CARD_HEIGHT)/2 + 30, 250, 350);
    } else if ([[UIScreen mainScreen] bounds].size.width == 375) {
        self.frame = CGRectMake((self.bounds.size.width - CARD_WIDTH)/2, (self.bounds.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT);
    } else if ([[UIScreen mainScreen] bounds].size.width > 375) {
        self.frame = CGRectMake((self.bounds.size.width - CARD_WIDTH)/2, (self.frame.size.height - 460)/2, CARD_WIDTH, 460);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


//%%% sets up the extra buttons on the screen
-(void)setupView {
    self.backgroundColor = [UIColor backgroundGrayColor]; //the gray background colors
}

//%%% creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
- (QuizDraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index {

    // couldn't figure out autolayout so did it this way
    if ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480) {
        self.draggableView = [[QuizDraggableView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 250)/2, (self.frame.size.height - 280)/2, 250, 330)];
    } else if ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 568) {
        self.draggableView = [[QuizDraggableView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 250)/2, (self.frame.size.height - CARD_HEIGHT)/2 + 30, 250, 350)];
    } else if ([[UIScreen mainScreen] bounds].size.width == 375) {
        self.draggableView = [[QuizDraggableView alloc] initWithFrame:CGRectMake((self.bounds.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
    } else if ([[UIScreen mainScreen] bounds].size.width > 375) {
        self.draggableView = [[QuizDraggableView alloc] initWithFrame:CGRectMake((self.bounds.size.width - CARD_WIDTH)/2, (self.frame.size.height - 460)/2, CARD_WIDTH , 460)];
    }

//    NSLayoutConstraint *bottomOfCardToBottomMarginConstraint = [NSLayoutConstraint constraintWithItem:draggableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:5];
//    [self addConstraint:bottomOfCardToBottomMarginConstraint];
//
//    NSLayoutConstraint *topOfCardToTopMarginConstraint = [NSLayoutConstraint constraintWithItem:draggableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:5];
//    [self addConstraint:topOfCardToTopMarginConstraint];
//
//    //NSLayoutConstraint *centerOfCardToCenterOfView = [NSLayoutConstraint constraintWithItem:draggableView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:1];
//    //[self addConstraint:centerOfCardToCenterOfView];
//
//    NSLayoutConstraint *leftOfCardToLeftMarginConstraint = [NSLayoutConstraint constraintWithItem:draggableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:5];
//    [self addConstraint:leftOfCardToLeftMarginConstraint];
//
//    NSLayoutConstraint *rightOfCardToRightMarginConstraint = [NSLayoutConstraint constraintWithItem:draggableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:5];
//    [self addConstraint:rightOfCardToRightMarginConstraint];

    //StudyDraggableView *draggableView = [[StudyDraggableView alloc] initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
//    draggableView.subjectView.titleLabel.text = [self.exampleCardLabels objectAtIndex:index]; //%%% placeholder for card-specific information
    Card *card = [self.topCardInDeck objectAtIndex:index];
    self.draggableView.frontView.frontLabel.text = card.title;
    self.draggableView.backView.backTextView.text = card.answer;
    self.draggableView.delegate = self;

    return self.draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
- (void)loadCards {
    if([self.topCardInDeck count] > 0) {
        NSInteger numLoadedCardsCap =(([self.topCardInDeck count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[self.topCardInDeck count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen

        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i < [self.topCardInDeck count]; i++) {
            QuizDraggableView *newCard = [self createDraggableViewWithDataAtIndex:i];
            [self.allCards addObject:newCard];

            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [self.loadedCards addObject:newCard];
            }
        }

        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data

        for (int i = 0; i<[self.loadedCards count]; i++) {
                if (i > 0) {
                    [self insertSubview:[self.loadedCards objectAtIndex:i] belowSubview:[self.loadedCards objectAtIndex:i - 1]];
                } else {
                    [self addSubview:[self.loadedCards objectAtIndex:i]];
                }
            self.cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
        

    }
}

//%%% action called when the card goes to the left.
// This should be customized with your own action
- (void)cardSwipedLeft:(UIView *)card {
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;

    [self.loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"

    if (self.cardsLoadedIndex < [self.allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [self.loadedCards addObject:[self.allCards objectAtIndex:self.cardsLoadedIndex]];
        self.cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    
    if (self.loadedCards.count == 0) {
        CompletionViewController *completionVC = [[CompletionViewController alloc] init];
        completionVC.deck = self.deck;
        completionVC.session = self.session;
        [self.quizVC.navigationController pushViewController:completionVC animated:YES];
    }
}

//%%% action called when the card goes to the right.
// This should be customized with your own action
- (void)cardSwipedRight:(UIView *)card {
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;

    [self.loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"

    if (self.cardsLoadedIndex < [self.allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [self.loadedCards addObject:[self.allCards objectAtIndex:self.cardsLoadedIndex]];
        self.cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)]
               belowSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    self.markedCorrect++;
    self.session.markedCorrect = [NSNumber numberWithInteger:self.markedCorrect];
    [[DeckController sharedInstance] save];
    NSLog(@"%@", self.session.markedCorrect);
    
    if (self.loadedCards.count == 0) {
        CompletionViewController *completionVC = [[CompletionViewController alloc] init];
        completionVC.deck = self.deck;
        completionVC.session = self.session;
        [self.quizVC.navigationController pushViewController:completionVC animated:YES];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSArray *)shuffleCards:(NSArray *)cards {
    
    NSMutableArray *mutableCards = [NSMutableArray arrayWithArray:cards];
    NSUInteger count = [mutableCards count];
    if (count > 1) {
        for (NSUInteger i  = count - 1; i > 0; --i) {
            [mutableCards exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((u_int32_t)(i + 1))];
        }
    }
    return mutableCards;
}

@end

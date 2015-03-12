//
//  StudyDraggableViewBackground.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StudyDraggableViewBackground.h"

static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 386; //%%% height of the draggable card
static const float CARD_WIDTH = 290; //%%% width of the draggable card

@interface StudyDraggableViewBackground ()

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, assign) NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
@property (nonatomic, strong) NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)

@end

@implementation StudyDraggableViewBackground

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        self.exampleCardLabels = [[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"last", nil]; //%%% placeholder for card-specific information
        self.loadedCards = [[NSMutableArray alloc] init];
        self.allCards = [[NSMutableArray alloc] init];
        self.cardsLoadedIndex = 0;
        [self loadCards];
    }
    return self;
}

//%%% sets up the extra buttons on the screen
-(void)setupView {
#warning customize all of this.  These are just place holders to make it look pretty
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    //    menuButton = [[UIButton alloc]initWithFrame:CGRectMake(17, 34, 22, 15)];
    //    [menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    //    messageButton = [[UIButton alloc]initWithFrame:CGRectMake(284, 34, 18, 18)];
    //    [messageButton setImage:[UIImage imageNamed:@"messageButton"] forState:UIControlStateNormal];
    //    xButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 485, 59, 59)];
    //    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    //    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    //    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 485, 59, 59)];
    //    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    //    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:menuButton];
    //    [self addSubview:messageButton];
    //    [self addSubview:xButton];
    //    [self addSubview:checkButton];
}

#warning include own card customization here!
//%%% creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
- (StudyDraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index {
    StudyDraggableView *draggableView = [[StudyDraggableView alloc] initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
    draggableView.subjectView.titleLabel.text = [self.exampleCardLabels objectAtIndex:index]; //%%% placeholder for card-specific information
    draggableView.delegate = self;
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
- (void)loadCards {
    if([self.exampleCardLabels count] > 0) {
        NSInteger numLoadedCardsCap =(([self.exampleCardLabels count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[self.exampleCardLabels count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen

        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i < [self.exampleCardLabels count]; i++) {
            StudyDraggableView *newCard = [self createDraggableViewWithDataAtIndex:i];
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

#warning include own action here!
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
}

#warning include own action here!
//%%% action called when the card goes to the right.
// This should be customized with your own action
- (void)cardSwipedRight:(UIView *)card {
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;

    [self.loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"

    if (self.cardsLoadedIndex < [self.allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [self.loadedCards addObject:[self.allCards objectAtIndex:self.cardsLoadedIndex]];
        self.cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

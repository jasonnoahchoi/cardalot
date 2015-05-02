//
//  QuizViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/14/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "QuizViewController.h"

#import "QuizDraggableViewBackground.h"
#import "Deck.h"
#import "DeckCollectionViewController.h"
#import "UIBarButtonItem+CustomButtons.h"
#import "UIColor+Colors.h"
#import "DeckController.h"
#import "QuizBackView.h"
#import "QuizFrontView.h"
#import "QuizDraggableView.h"

@interface QuizViewController ()

@property (nonatomic, strong) DeckCollectionViewController *deckCollectionVC;
@property (nonatomic, assign) BOOL flipped;
@property (nonatomic, strong) QuizFrontView *frontView;
@property (nonatomic, strong) QuizBackView *backView;
@property (nonatomic, strong) QuizDraggableView *draggableView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flipped = NO;
    [self layoutNavigationBarItems];
    [self layoutSubviews];
}
- (void)layoutSubviews {
    self.view.backgroundColor = [UIColor backgroundGrayColor];
    self.draggableViewBackground = [[QuizDraggableViewBackground alloc] initWithFrame:self.view.bounds];
    self.draggableViewBackground.deck = self.deck;
    [self.draggableViewBackground setCards:[self.deck.cards.set allObjects]];
    [self.draggableViewBackground setTopCardInDeck:[self.draggableViewBackground shuffleCards:self.draggableViewBackground.cards]];
    self.draggableViewBackground.type = self.type;
    self.draggableViewBackground.session = self.session;
    self.draggableViewBackground.quizVC = self;
    [self.draggableViewBackground loadCards];
    [self.view addSubview:self.draggableViewBackground];
}

- (void)layoutNavigationBarItems {
    NSString *string = [NSString stringWithFormat:@"Quiz: %@", self.deck.nameTag];
    self.navigationItem.title = string;

    UIImage *backIcon = [UIImage imageNamed:@"backbutton"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backButtonWithImage:backIcon target:self action:@selector(backButtonAction)];
   // [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)backButtonAction {
    Session *session = [self.deck.sessions lastObject];
    [[DeckController sharedInstance] removeSession:session];
    [[DeckController sharedInstance] save];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

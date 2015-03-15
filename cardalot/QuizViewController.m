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

@interface QuizViewController ()

@property (nonatomic, strong) DeckCollectionViewController *deckCollectionVC;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self layoutNavigationBarItems];
    [self layoutSubviews];
}

- (void)layoutSubviews {
    self.draggableViewBackground = [[QuizDraggableViewBackground alloc] initWithFrame:self.view.frame];
    self.draggableViewBackground.deck = self.deck;
    [self.draggableViewBackground setTopCardInDeck:[self.deck.cards.set allObjects]];
    [self.draggableViewBackground loadCards];
    [self.view addSubview:self.draggableViewBackground];
}

- (void)layoutNavigationBarItems {
   // NSString *string = [NSString stringWithFormat:@"Studying %@", self.deck.nameTag];
    self.navigationItem.title = @"Quiz Mode";

    UIImage *backIcon = [UIImage imageNamed:@"backbutton"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backButtonWithImage:backIcon target:self action:@selector(backButtonAction)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor customBlueColor]];

    UIImage *quizIconOrange = [UIImage imageNamed:@"Qorangeicon"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem quizButtonWithImage:quizIconOrange target:nil action:nil];
}

- (void)test {
    NSLog(@"Button");
}

- (void)backButtonAction {
    Session *session = [self.deck.sessions lastObject];
    [[DeckController sharedInstance] removeSession:session];
    [[DeckController sharedInstance] save];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

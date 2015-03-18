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
//@property (nonatomic, assign) BOOL flipped;
@property (nonatomic, strong) QuizFrontView *frontView;
@property (nonatomic, strong) QuizBackView *backView;
@property (nonatomic, strong) QuizDraggableView *draggableView;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self layoutNavigationBarItems];
    [self layoutSubviews];

//    self.flipped = NO;
//
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    tapGesture.numberOfTapsRequired = 2;
//
//    [self.draggableViewBackground addGestureRecognizer:tapGesture];


}

//- (void)handleTap:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateEnded) {
//      //  [UIView transitionFromView:self.draggableViewBackground.draggableView.frontView toView:self.draggableViewBackground.draggableView.backView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight
//                 //       completion:nil];
//        [UIView transitionWithView:self.draggableViewBackground
//                          duration:1
//                           options:UIViewAnimationOptionTransitionFlipFromTop|UIViewAnimationCurveEaseIn
//                        animations:^{
//                            if (!self.flipped) {
//                                [self.draggableViewBackground.draggableView.frontView setHidden:NO];
//                              //  [self.draggableViewBackground addSubview:self.draggableViewBackground.draggableView.frontView];
//                               // [self.draggableViewBackground bringSubviewToFront:self.draggableViewBackground.draggableView.backView];
//                              //  [self.draggableViewBackground.draggableView.frontView removeFromSuperview];
////                                [self.draggableViewBackground addSubview:self.draggableViewBackground.draggableView.backView];
//                              //  [self.draggableViewBackground.draggableView.backView setHidden:NO];
//                                self.flipped = YES;
//                            } else {
////                                [self.draggableViewBackground.draggableView.backView setHidden:NO];
//                                [self.draggableViewBackground.draggableView.frontView setHidden:YES];
//                                [self.draggableViewBackground.draggableView.frontView removeFromSuperview];
//
//                                //[self.draggableViewBackground bringSubviewToFront:self.draggableViewBackground.draggableView.backView];
//                               // [self.draggableViewBackground.draggableView.backView removeFromSuperview];
//                               // [self.draggableViewBackground.draggableView.frontView setHidden:NO];
//                                self.flipped = NO;
//                            }
//                        }
//                        completion:nil];
//    }
//}
- (void)layoutSubviews {
    self.view.backgroundColor = [UIColor backgroundGrayColor];
    self.draggableViewBackground = [[QuizDraggableViewBackground alloc] initWithFrame:self.view.bounds];
    self.draggableViewBackground.deck = self.deck;
    [self.draggableViewBackground setCards:[self.deck.cards.set allObjects]];
    [self.draggableViewBackground setTopCardInDeck:[self.draggableViewBackground shuffleCards:self.draggableViewBackground.cards]];
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

//
//  ViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckCollectionViewController.h"
#import "DeckCollectionViewDataSource.h"
#import "DeckController.h"
#import "DeckCollectionViewLayout.h"
#import "DeckCollectionViewCell.h"
#import "CardViewController.h"
#import "CardCollectionViewController.h"
#import "Card.h"
#import "Deck.h"
#import "StudyViewController.h"
#import "StudyDraggableViewBackground.h"
#import "QuizViewController.h"
#import "UIColor+Colors.h"
#import "Session.h"
#import "RateAppViewController.h"
#import "StorePurchaseController.h"

@import StoreKit;
#import <MMDrawerController.h>

static NSString * const cellIdentifier = @"cell";
static int count = 0;
static int quizMode;
static int studyMode;

@interface DeckCollectionViewController () <UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DeckCollectionViewDataSource *dataSource;
@property (nonatomic, strong) DeckCollectionViewLayout *deckLayout;
@property (nonatomic, strong) DeckCollectionViewCell *deckCell;
@property (nonatomic, strong) UIBarButtonItem *studyButton;
@property (nonatomic, strong) UIBarButtonItem *quizButton;

@end

@implementation DeckCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.deckLayout = [[DeckCollectionViewLayout alloc] init];

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                             collectionViewLayout:self.deckLayout];
    self.collectionView.backgroundColor = [UIColor backgroundGrayColor];
    [self.view addSubview:self.collectionView];
    
    self.dataSource = [DeckCollectionViewDataSource new];
    self.collectionView.dataSource = self.dataSource;
    [self.dataSource registerCollectionView:self.collectionView];
    self.dataSource.deckCollectionVC = self;
    
    self.collectionView.delegate = self;

    // Disable/Enable Drawer Gestures
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    [self loadBarButtonItems];
    [self inAppPurchase];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
}
#pragma mark - In App Purchases
- (void)inAppPurchase {
    [[StorePurchaseController sharedInstance] requestProducts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsRequested:) name:kInAppPurchaseFetchedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsPurchased:) name:kInAppPurchaseCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsRestored:) name:kInAppPurchaseRestoredNotification object:nil];
}

- (void)productsRequested:(NSNotification *)notification {
    [self.collectionView reloadData];
}

- (void)productsPurchased:(NSNotification *)notification {

}

- (void)productsRestored:(NSNotification *)notification {

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Navigation Items

- (void)loadBarButtonItems {
    self.title = @"Decks";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(open)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];

    UIImage *studyIconGray = [UIImage imageNamed:@"Syellowicon"];
    UIImage *quizIconGray = [UIImage imageNamed:@"Qorangeicon"];

    self.studyButton = [[UIBarButtonItem alloc] initWithImage:studyIconGray
                                                        style:UIBarButtonItemStylePlain
                                                       target:self
                                                       action:@selector(studyMode)];
    self.quizButton = [[UIBarButtonItem alloc] initWithImage:quizIconGray
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(quizMode)];
    [self.studyButton setTintColor:[UIColor lightGrayColor]];
    [self.quizButton setTintColor:[UIColor lightGrayColor]];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    [addButton setTintColor:[UIColor whiteColor]];

    self.navigationItem.rightBarButtonItems = @[addButton, self.quizButton, self.studyButton];
}

#pragma mark - Mode State Methods

- (int)quizModeFalse {
    quizMode = !kQuizMode;
    [self.quizButton setTintColor:[UIColor customOrangeColor]];
    [self.studyButton setEnabled:NO];
    return quizMode;
}

- (int)quizModeTrue {
    quizMode = kQuizMode;
    [self.quizButton setTintColor:[UIColor customGrayColor]];
    [self.studyButton setEnabled:YES];
    return quizMode;
}

- (int)studyModeTrue {
    studyMode = kStudyMode;
    [self.studyButton setTintColor:[UIColor customYellowColor]];
    [self.quizButton setEnabled:NO];
    return studyMode;
}

- (int)studyModeFalse {
    studyMode = !kStudyMode;
    [self.studyButton setTintColor:[UIColor customGrayColor]];
    [self.quizButton setEnabled:YES];
    return studyMode;
}

- (void)studyMode {
    count++;
    if (count % 2 != 0) {
        [self studyModeTrue];
    } else {
        [self studyModeFalse];
    }
}

- (IBAction)quizMode {
    count++;
    if (count % 2 != 0) {
        [self quizModeFalse];
    } else {
        [self quizModeTrue];
    }
}

#pragma mark - Drawer Method

- (void)open {
    if (self.drawerController.openSide) {
        NSLog(@"pressed");
        [self.drawerController closeDrawerAnimated:YES completion:nil];
    } else {
        [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

#pragma mark - Collection View Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.item == [DeckController sharedInstance].decks.count) {
            NSLog(@"Create a new deck");
            [self createNewDeckAlertController];
        } else {
            NSLog(@"A cell has been pressed");
            if (studyMode) {
                NSLog(@"Study Mode");

                Deck *deck = [DeckController sharedInstance].decks[indexPath.item];
                [[DeckController sharedInstance] addSessionToDeck:deck withMode:kStudyMode];
                Session *session = [deck.sessions lastObject];
             //   session.mode = [NSNumber numberWithInt:kStudyMode];

                StudyViewController *studyVC = [[StudyViewController alloc] init];

                studyVC.deck = deck;
                studyVC.session = session;

                [self.navigationController pushViewController:studyVC animated:YES];
            } else if (quizMode) {
                NSLog(@"QuizMode");
                Deck *deck = [DeckController sharedInstance].decks[indexPath.item];
                [[DeckController sharedInstance] addSessionToDeck:deck withMode:kQuizMode];
                Session *session = [deck.sessions lastObject];

                QuizViewController *quizVC = [[QuizViewController alloc] init];

                quizVC.deck = deck;
                quizVC.session = session;
                [self.navigationController pushViewController:quizVC animated:YES];

            } else if (!studyMode && !quizMode) {
                CardCollectionViewController *cardCollectionVC = [[CardCollectionViewController alloc] init];
                Deck *deck = [DeckController sharedInstance].decks[indexPath.item];
                cardCollectionVC.deck = deck;
                [self.navigationController pushViewController:cardCollectionVC animated:YES];
            }
        }
}

#pragma mark - Add button

- (void)addItem:(id)sender {
    CardViewController *cardVC = [[CardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];

}

#pragma mark - Helper Method

- (void)createNewDeckAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Deck"
                                                                             message:@"Choose a name for your new deck"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {

        self.deckTitle = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
        [[DeckController sharedInstance] addDeckWithName:self.deckTitle];
        if ([DeckController sharedInstance].decks.count >= 5) {
            UIAlertController *deckLimitAlert = [UIAlertController alertControllerWithTitle:@"You've reached your limit!" message:@"You can get unlimited decks with more features coming soon by upgrading to our pro version!" preferredStyle:UIAlertControllerStyleAlert];
            [deckLimitAlert addAction:[UIAlertAction actionWithTitle:@"Go Pro" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[StorePurchaseController sharedInstance] requestProducts];
            }]];

            [deckLimitAlert addAction:[UIAlertAction actionWithTitle:@"No, thanks" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"Not buying pro");
            }]];

            [self presentViewController:deckLimitAlert animated:YES completion:nil];
        }
        [[DeckController sharedInstance] save];
        [self.collectionView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"cancel");
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end

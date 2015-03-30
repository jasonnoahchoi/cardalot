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
#import "PurchasedDataController.h"

@import StoreKit;
#import <MMDrawerController.h>

static NSString * const cellIdentifier = @"cell";
//static int count = 0;
static int quizMode;
static int studyMode;
BOOL goPro;

@interface DeckCollectionViewController () <UICollectionViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DeckCollectionViewDataSource *dataSource;
@property (nonatomic, strong) DeckCollectionViewLayout *deckLayout;
@property (nonatomic, strong) DeckCollectionViewCell *deckCell;
//@property (nonatomic, strong) UIBarButtonItem *studyButton;
//@property (nonatomic, strong) UIBarButtonItem *quizButton;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

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
    goPro = [PurchasedDataController sharedInstance].goPro;

    // Disable/Enable Drawer Gestures
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    [self loadBarButtonItems];
    [self inAppPurchase];
    [self.collectionView setContentInset:UIEdgeInsetsMake(40, 0, 100, 0)];

//    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"A", @"B"]];
//   // self.segmentedControl.frame = CGRectMake(0, 0, 200, 20);
//    [self.view addSubview:self.segmentedControl];
//    [self.segmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
//
//    NSLayoutConstraint *middleConstraint = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//
//    [self.view addConstraint:middleConstraint];
//
//
//    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:15];
//
//    [self.view addConstraint:leadingConstraint];
//
//    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:15];
//
//    [self.view addConstraint:trailingConstraint];

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
    goPro = YES;
    [self.collectionView reloadData];
}

- (void)productsRestored:(NSNotification *)notification {
    goPro = YES;
    [self.collectionView reloadData];
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

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    [addButton setTintColor:[UIColor whiteColor]];

    self.navigationItem.rightBarButtonItem = addButton;

    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Prepare", @"Study", @"Quiz"]];
    [segmentedControl sizeToFit];
    [segmentedControl setTintColor:[UIColor customBlueColor]];
    [segmentedControl setBackgroundColor:[UIColor whiteColor]];
    segmentedControl.selectedSegmentIndex = 0;

    [containerView addSubview:segmentedControl];
    [segmentedControl addTarget:self action:@selector(modeChanged:) forControlEvents:UIControlEventValueChanged];

    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray *viewConstraint = [NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[containerView]-|"
                               options:NSLayoutFormatAlignAllCenterX
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(containerView)];
    [self.view addConstraints:viewConstraint];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:70];
    [self.view addConstraint:topConstraint];

    [segmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray *constraint = [NSLayoutConstraint
                           constraintsWithVisualFormat:@"H:|-[segmentedControl]-|"
                           options:NSLayoutFormatAlignAllCenterX
                           metrics:nil
                           views:NSDictionaryOfVariableBindings(segmentedControl)];
    [containerView addConstraints:constraint];
    NSArray *constraintV = [NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:|-[segmentedControl]-|"
                           options:NSLayoutFormatAlignAllCenterY
                           metrics:nil
                           views:NSDictionaryOfVariableBindings(segmentedControl)];
    [containerView addConstraints:constraintV];
}

- (void)modeChanged:(UISegmentedControl *)segment {

    switch (segment.selectedSegmentIndex) {
        case 0:{
            quizMode = kQuizMode;
            studyMode = !kStudyMode;
            break;
        }
        case 1:{
            studyMode = kStudyMode;
            quizMode = !kQuizMode;
            break;
        }
        case 2:{
            studyMode = !kStudyMode;
            quizMode = !kQuizMode;
            break;
        }
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
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    }];

    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {

        self.deckTitle = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
        [[DeckController sharedInstance] addDeckWithName:self.deckTitle];
        if ( [DeckController sharedInstance].decks.count >= 5 && [PurchasedDataController sharedInstance].goPro == NO) {
            UIAlertController *deckLimitAlert = [UIAlertController
                                                 alertControllerWithTitle:@"Go Pro for Unlimited Decks!"
                                                 message:@"You have unlimited cards so if you rather not go pro, hold down on a deck to delete it."
                                                 preferredStyle:UIAlertControllerStyleAlert];
            [deckLimitAlert addAction:[UIAlertAction actionWithTitle:@"Go Pro"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                [[StorePurchaseController sharedInstance] purchaseOptionSelectedObjectIndex:0];
            }]];

            [deckLimitAlert addAction:[UIAlertAction actionWithTitle:@"No, thanks"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                NSLog(@"Not buying pro");
            }]];
            [self presentViewController:deckLimitAlert animated:YES completion:nil];
        }

        [[DeckController sharedInstance] save];
        [self.collectionView reloadData];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UITextFieldTextDidChangeNotification
                                                      object:nil];
    }];
    [alertController addAction:saveAction];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
        NSLog(@"cancel");
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UITextFieldTextDidChangeNotification
                                                      object:nil];
    }]];

    saveAction.enabled = NO;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertTextFieldDidChange:(NSNotification *)notification {
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *deckNameField = alertController.textFields.firstObject;
        UIAlertAction *saveAction = alertController.actions.firstObject;
        saveAction.enabled = deckNameField.text.length > 0;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        [self dismissViewControllerAnimated:YES completion:^{
            self.deckTitle = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
            [[DeckController sharedInstance] addDeckWithName:self.deckTitle];
            if ( [DeckController sharedInstance].decks.count >= 5 && [PurchasedDataController sharedInstance].goPro == NO) {
                UIAlertController *deckLimitAlert = [UIAlertController
                                                     alertControllerWithTitle:@"You've reached your limit!"
                                                     message:@"You can get unlimited decks with more features coming soon by upgrading to our pro version!"
                                                     preferredStyle:UIAlertControllerStyleAlert];
                [deckLimitAlert addAction:[UIAlertAction actionWithTitle:@"Go Pro"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction *action) {
                    [[StorePurchaseController sharedInstance] purchaseOptionSelectedObjectIndex:0];
                }]];
                
                [deckLimitAlert addAction:[UIAlertAction actionWithTitle:@"No, thanks"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction *action) {
                    NSLog(@"Not buying pro");
                }]];

                [self presentViewController:deckLimitAlert animated:YES completion:nil];
            }
            
            [[DeckController sharedInstance] save];
            [self.collectionView reloadData];
        }];
    }
    return YES;
}

@end

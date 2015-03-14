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
#import "UIColor+Colors.h"
#import "Session.h"

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
}

- (void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

#pragma mark - Navigation Items

- (void)loadBarButtonItems {
    self.title = @"Decktags";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(open)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor customBlueColor]];

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
    [self.studyButton setTintColor:[UIColor customGrayColor]];
    [self.quizButton setTintColor:[UIColor customGrayColor]];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    [addButton setTintColor:[UIColor customBlueColor]];

    self.navigationItem.rightBarButtonItems = @[addButton, self.quizButton, self.studyButton];
}

#pragma mark - Mode State Methods

- (int)quizModeTrue {
    quizMode = kQuizMode;
    [self.quizButton setTintColor:[UIColor customOrangeColor]];
    [self.studyButton setEnabled:NO];
    return quizMode;
}

- (int)quizModeFalse {
    quizMode = !kQuizMode;
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
        [self quizModeTrue];
    } else {
        [self quizModeFalse];
    }
}

#pragma mark - Drawer Method

- (void)open {
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
            //    Session *session = [deck.sessions lastObject];
             //   session.mode = [NSNumber numberWithInt:kStudyMode];

                StudyViewController *studyVC = [[StudyViewController alloc] init];

                studyVC.deck = deck;

                [self.navigationController pushViewController:studyVC animated:YES];
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
                                                                             message:@"Enter tag of new deck"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save"
                                                        style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.deckTitle = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
        [[DeckController sharedInstance] addDeckWithName:self.deckTitle];
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

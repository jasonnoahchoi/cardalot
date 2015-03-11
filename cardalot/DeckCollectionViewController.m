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

#import <MMDrawerController.h>

static NSString * const cellIdentifier = @"cell";

@interface DeckCollectionViewController () <UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DeckCollectionViewDataSource *dataSource;
@property (nonatomic, strong) DeckCollectionViewLayout *deckLayout;
@property (nonatomic, strong) DeckCollectionViewCell *cell;

@end

@implementation DeckCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Decktags";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    
    self.deckLayout = [[DeckCollectionViewLayout alloc] init];

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.deckLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.dataSource = [DeckCollectionViewDataSource new];
    self.collectionView.dataSource = self.dataSource;
    [self.dataSource registerCollectionView:self.collectionView];
    
    self.collectionView.delegate = self;

    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createCloseButton) name:presentAlert object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

- (void)open {
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = (DeckCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.item == [DeckController sharedInstance].decks.count) {
        NSLog(@"last cell");
        [self createNewDeckAlertController];
    } else {
        NSLog(@"some other cell");
        CardCollectionViewController *cardCollectionVC = [[CardCollectionViewController alloc] init];
        Deck *deck = [DeckController sharedInstance].decks[indexPath.item];
        cardCollectionVC.deck = deck;
        [self.navigationController pushViewController:cardCollectionVC animated:YES];
    }
}

- (void)addItem:(id)sender {
    CardViewController *cardVC = [[CardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];
}

- (void)createNewDeckAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Deck" message:@"Enter tag of new deck" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.deckTitle = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
        [[DeckController sharedInstance] addDeckWithName:self.deckTitle];
        [[DeckController sharedInstance] save];

        [self.collectionView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"cancel");
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Delete Cell Methods

- (void)createCloseButton {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Remove Deck" message:@"Are you sure you want to remove deck? All cards inside the deck will be erased." preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSIndexPath *indexPath = [self.collectionView indexPathForCell:self.cell];
            
            Deck *deck = [DeckController sharedInstance].decks[indexPath.item];
            [[DeckController sharedInstance] removeDeck:deck];
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            
            [self.collectionView reloadData];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        // [self.collectionView.visibleCells makeObjectsPerformSelector:@selector(startJiggling)];
        NSLog(@"Close Button");
}

//- (void)deleteItem:(int)i {
//    [self.collectionView performBatchUpdates:^{
////        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[DeckController sharedInstance].decks];
////        [array removeObjectAtIndex:i];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        Deck *deck = [DeckController sharedInstance].decks[indexPath.item];
//        [[DeckController sharedInstance] removeDeck:deck];
//        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//        NSLog(@"Delete item: %d", i);
//    } completion:^(BOOL finished) {
//        NSLog(@"Delete cell!");
//    }];
//
//    [self.collectionView reloadData];
//}

@end

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

@interface DeckCollectionViewController () <UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DeckCollectionViewDataSource *dataSource;

@end

@implementation DeckCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.dataSource = [DeckCollectionViewDataSource new];
    self.collectionView.dataSource = self.dataSource;
    [self.dataSource registerCollectionView:self.collectionView];
    
    self.collectionView.delegate = self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == [DeckController sharedInstance].decks.count) {
        NSLog(@"last cell");
        [self createNewDeckAlertController];
    } else {
        NSLog(@"some other cell");
    }
}

- (void)createNewDeckAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Deck" message:@"Enter tag of new deck" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"new deck!");
        NSString *deckTag = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
        [[DeckController sharedInstance] addDeckWithName:deckTag];
        [self.collectionView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"cancel");
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

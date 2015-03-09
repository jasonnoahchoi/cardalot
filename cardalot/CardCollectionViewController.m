//
//  CardCollectionViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardCollectionViewController.h"
#import "CardCollectionViewDataSource.h"
#import "CardCollectionViewCell.h"
#import <MTCardLayout/MTCardLayout.h>
#import <MTCardLayout/UICollectionView+CardLayout.h>

@interface CardCollectionViewController () <UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CardCollectionViewDataSource *dataSource;

@end

@implementation CardCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditingMode:)];
    
    MTCardLayout *cardLayout = [[MTCardLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:cardLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.dataSource = [[CardCollectionViewDataSource alloc] init];
    self.collectionView.dataSource = self.dataSource;
    [self.dataSource registerCollectionView:self.collectionView];
    
    self.collectionView.delegate = self;
}

#pragma mark IBAction
- (IBAction)toggleEditingMode:(id)sender {
    UIBarButtonItem *barButtonItem = sender;
    
    CardCollectionViewCell *cell = (CardCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]];
    
    if (self.isEditing) {
        [cell.textField setEnabled:NO];
        cell.textView.editable = NO;
        
        [barButtonItem setTitle:@"Edit"];
        [self setEditing:NO animated:YES];
    } else {
        [cell.textField setEnabled:YES];
        cell.textView.editable = YES;
        
        [barButtonItem setTitle:@"Done"];
        [self setEditing:YES animated:YES];
    }
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView setPresenting:YES animated:YES completion:nil];
}

@end

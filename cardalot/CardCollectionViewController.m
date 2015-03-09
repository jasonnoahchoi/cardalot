//
//  CardCollectionViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardCollectionViewController.h"
#import "CardCollectionViewDataSource.h"
#import <MTCardLayout/MTCardLayout.h>
#import <MTCardLayout/UICollectionView+CardLayout.h>

@interface CardCollectionViewController () <UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CardCollectionViewDataSource *dataSource;

@end

@implementation CardCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTCardLayout *cardLayout = [[MTCardLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:cardLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.dataSource = [[CardCollectionViewDataSource alloc] init];
    self.collectionView.dataSource = self.dataSource;
    [self.dataSource registerCollectionView:self.collectionView];
    
    self.collectionView.delegate = self;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView setPresenting:YES animated:YES completion:nil];
}

@end

//
//  CardCollectionViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardCollectionViewController.h"
#import <MTCardLayout/MTCardLayout.h>

@interface CardCollectionViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CardCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTCardLayout *cardLayout = [[MTCardLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:cardLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

@end

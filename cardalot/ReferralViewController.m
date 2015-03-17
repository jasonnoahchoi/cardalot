//
//  ReferralViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "ReferralViewController.h"
#import "DeckCollectionViewController.h"
#import <MMDrawerController.h>

@interface ReferralViewController ()

@end

@implementation ReferralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Refer Friends";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 50)];
    tempLabel.text = @"Referral View Controller";
    
    [self.view addSubview:tempLabel];
    
}

- (void)open {
    if (self.drawerController.openSide) {
        [self.drawerController closeDrawerAnimated:YES completion:nil];
    } else {
        [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

@end

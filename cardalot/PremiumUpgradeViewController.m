//
//  PremiumUpgradeViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "PremiumUpgradeViewController.h"
#import "DeckCollectionViewController.h"

@interface PremiumUpgradeViewController ()

@end

@implementation PremiumUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *background = [UIImage imageNamed: @"GoPremiumInProcess.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    
    [self.view addSubview: imageView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
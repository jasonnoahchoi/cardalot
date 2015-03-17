//
//  PremiumUpgradeViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "PremiumUpgradeViewController.h"
#import "DeckCollectionViewController.h"
#import <MMDrawerController.h>

@interface PremiumUpgradeViewController ()

@end

@implementation PremiumUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Cardalot Premium";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *background = [UIImage imageNamed: @"GoPremiumInProcess.png"];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    imageView.image = background;
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview: imageView];
    
    
}

- (void)open {
    if (self.drawerController.openSide) {
        [self.drawerController closeDrawerAnimated:YES completion:nil];
    } else {
        [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
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

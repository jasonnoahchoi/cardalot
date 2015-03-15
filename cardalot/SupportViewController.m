//
//  SupportViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/15/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "SupportViewController.h"
#import <MMDrawerController.h>

@interface SupportViewController ()

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
    self.title = @"Supportatlot";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 50)];
    tempLabel.text = @"Please feel free to reachout to your cardalot team";
    
    [self.view addSubview:tempLabel];
    
}

- (void)open {
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}



@end

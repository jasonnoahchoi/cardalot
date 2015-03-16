//
//  AdvancedSettingsViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/15/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "AdvancedSettingsViewController.h"
#import <MMDrawerController.h>

@interface AdvancedSettingsViewController ()

@end

@implementation AdvancedSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"Advanced Settings";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 50)];
    tempLabel.text = @"Here will be the advanced Settinfs";
    
    [self.view addSubview:tempLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)open {
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}



@end

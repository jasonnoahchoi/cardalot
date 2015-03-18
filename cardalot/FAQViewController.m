//
//  FAQViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/15/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "FAQViewController.h"
#import <MMDrawerController.h>

@interface FAQViewController ()

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"FAQ";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 50)];
    tempLabel.text = @"FAQ";
    
    [self.view addSubview:tempLabel];
}

- (void)done {
//    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

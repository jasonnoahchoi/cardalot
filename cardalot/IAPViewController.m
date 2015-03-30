//
//  IAPViewController.m
//  Cardalot
//
//  Created by Jason Noah Choi on 3/30/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "IAPViewController.h"
#import "StorePurchaseController.h"
#import <MMDrawerController.h>

@interface IAPViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *purchaseCell;
@property (nonatomic, strong) UITableViewCell *restoreCell;

@end

@implementation IAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Account Type";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.purchaseCell = [[UITableViewCell alloc] init];
    self.restoreCell = [[UITableViewCell alloc] init];
    self.purchaseCell.textLabel.text = @"Go Pro";
    self.restoreCell.textLabel.text = @"Restore Purchases";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)open {
    if (self.drawerController.openSide) {
        [self.drawerController closeDrawerAnimated:YES completion:nil];
    } else {
        [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case kFirstCell:
            [[StorePurchaseController sharedInstance] purchaseOptionSelectedObjectIndex:0];
            break;
        case kSecondCell:
            [[StorePurchaseController sharedInstance] restorePurchases];
            break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case kFirstCell:
            return self.purchaseCell;
            break;
        case kSecondCell:
            return self.restoreCell;
            break;
        default:
            break;
    }
    return nil;
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

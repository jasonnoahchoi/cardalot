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
#import "UIColor+Colors.h"

@interface IAPViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *purchaseCell;
@property (nonatomic, strong) UITableViewCell *restoreCell;

@end

@implementation IAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Account Type";
    self.view.backgroundColor = [UIColor customBlueColor];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect footerRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2);
    UIView *view = [[UIView alloc] initWithFrame:footerRect];
    view.backgroundColor = [UIColor customBlueColor];
    UILabel *tableFooterLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, self.view.frame.size.width-30, 100)];
    [view addSubview:tableFooterLabel];
    tableFooterLabel.backgroundColor = [UIColor customBlueColor];
    tableFooterLabel.numberOfLines = 0;
    tableFooterLabel.layer.cornerRadius = 10;
    tableFooterLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    tableFooterLabel.layer.borderWidth = 3;
    tableFooterLabel.layer.shouldRasterize = YES;
    tableFooterLabel.layer.masksToBounds = YES;
    tableFooterLabel.textAlignment = NSTextAlignmentCenter;
    tableFooterLabel.textColor = [UIColor whiteColor];
    tableFooterLabel.text = @"By going pro, you'll have access to unlimited decks with many more features coming soon";
    tableFooterLabel.font = [UIFont boldSystemFontOfSize:19];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.view.bounds.size.height - self.purchaseCell.frame.size.height - self.restoreCell.frame.size.height - 64;
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

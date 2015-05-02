//
//  AdvancedSettingsViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/15/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "AdvancedSettingsViewController.h"
#import "CardViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>

@interface AdvancedSettingsViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AdvancedSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"Advanced Settings";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCard)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
//    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 50)];
//    tempLabel.text = @"Here will be the advanced Settinfs";
//    
//    [self.view addSubview:tempLabel];
    
    // Create tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // Datasource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // sets static cell
    self.logoutCell = [UITableViewCell new];
    self.logoutCell.textLabel.text = @"Logout from cardalot";
    self.logoutCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Disable/Enable selection
    self.tableView.allowsSelection = YES;
    
    // Add to view
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
        case 0:  return 1;  // section 0 has 2 rows
        default: return 0;
    };
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    //    cell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
    //    NSAttributedString *attText = [[NSAttributedString alloc]initWithString:menuListArray[indexPath.row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Marion-Bold" size:16]}];
    //    cell.textLabel.attributedText = attText;
    
    switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
                case 0: return self.logoutCell;
            }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UINavigationController *navigationController = (UINavigationController *)self.mm_drawerController.centerViewController;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {

        }
    }
}

// Sets the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section) {
        case 0: return @"Stop Use of cardalot";
    }
    return nil;
}

- (void)done {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCard {
    CardViewController *cardVC = [[CardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];
}

@end

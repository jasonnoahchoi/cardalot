//
//  LegalInformationViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/14/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "LegalInformationViewController.h"
#import <MMDrawerController.h>

@interface LegalInformationViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LegalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Legal";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    
    // Create tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // Datasource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Sets static cells
    self.attributionCell = [UITableViewCell new];
    self.attributionCell.textLabel.text = @"Attributions";
    
    self.privacyPolicyCell = [UITableViewCell new];
    self.privacyPolicyCell.textLabel.text = @"Privacy Policy";
    
    self.termsOfServiceCell = [UITableViewCell new];
    self.termsOfServiceCell.textLabel.text = @"Terms of Use";
    
    // Disable/Enable selection
    self.tableView.allowsSelection = YES;
    
    // Add to view
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
        case 0:  return 1;  // section 0 has 2 rows
        case 1:  return 1;  // section 1 has 2 row
        case 2: return 1;  // section 2 has 2 row
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
                case 0: return self.attributionCell;
            }
        case 1:
            switch(indexPath.row) {
                case 0: return self.privacyPolicyCell;
            }
        case 2:
            switch (indexPath.row) {
                case 0: return self.termsOfServiceCell;
            }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIView *attributionsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:attributionsView];
            UILabel *attributionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, self.view.frame.size.width - 20, self.view.frame.size.height - 90)];
            attributionLabel.text = @"";
            attributionLabel.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
            attributionLabel.alpha = 0.9;
            attributionLabel.numberOfLines = 0;
            [attributionsView addSubview:attributionLabel];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIView *privacyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:privacyView];
            UILabel *privacyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, self.view.frame.size.width - 20, self.view.frame.size.height - 90)];
            privacyLabel.text = @"";
            privacyLabel.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
            privacyLabel.numberOfLines = 0;
            [privacyView addSubview:privacyLabel];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UIView *termsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:termsView];
            UILabel *termsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, self.view.frame.size.width - 20, self.view.frame.size.height - 90)];
            termsLabel.text = @"";
            termsLabel.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
            termsLabel.numberOfLines = 0;
            [termsView addSubview:termsLabel];
        }
    }
}

// Sets the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section) {
        case 0: return @"Attributions";
        case 1: return @"Privacy Policy";
        case 2: return @"Terms of Service";
    }
    return nil;
}

- (void)open {
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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

//
//  MenuDrawerViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "MenuDrawerViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>

@interface MenuDrawerViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LogoMenuCell *logoMenuCell;
@property (nonatomic, strong) SearchCell *searchCell;

@end

@implementation MenuDrawerViewController

// sets conent offset for search bar pull down
//- (void)viewWillAppear:(BOOL)animated
//{
//    self.tableView.contentOffset = CGPointMake(0, self.searchCell.frame.size.height);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set title
    self.title = @"Cardalot";
    
    // Create tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // Dismiss keyboard on scroll
    [self.view endEditing:YES];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    // Disable/Enable selection cell highlight
    self.tableView.allowsSelection = YES;

    
    // Removes seperator lines
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Datasource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Background Color of TableView
    self.tableView.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
    

    // Add to view
    [self.view addSubview:self.tableView];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row == 0) {
//        self.searchCell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
//        self.searchCell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
//        self.searchCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return self.searchCell;
    //}
    if (indexPath.row == 0) {
        self.logoMenuCell = [[LogoMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        self.logoMenuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.logoMenuCell;
    } else {  // for string with format add the itentifier for account type
        NSArray *menuListArray = @[[NSString stringWithFormat:@"Account Type: FREE"], @"History/Stats", @"Rate App", @"Go Premium", @"Refer Friends", @"Settings"];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
        NSAttributedString *attText = [[NSAttributedString alloc]initWithString:menuListArray[indexPath.row - 1] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Marion-Bold" size:16]}];
        cell.textLabel.attributedText = attText;
        // removes highlighting of cells when selecting
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - sets the tableview links to ViewControllers
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UINavigationController *navigationController = (UINavigationController *)self.mm_drawerController.centerViewController;
    
    if (indexPath.row == 0) {
        DeckCollectionViewController *deckCollectionVC = [DeckCollectionViewController new];
        deckCollectionVC.drawerController = self.mm_drawerController;
        UINavigationController *deckHomeNavController = [[UINavigationController alloc] initWithRootViewController:deckCollectionVC];
        [self.mm_drawerController setCenterViewController:deckHomeNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (indexPath.row == 2) {
        StatsViewController *statsVC = [StatsViewController new];
        statsVC.drawerController = self.mm_drawerController;
        UINavigationController *statsNavController =[[UINavigationController alloc] initWithRootViewController:statsVC];
        [self.mm_drawerController setCenterViewController:statsNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (indexPath.row == 3) {
        RateAppViewController *rateVC = [RateAppViewController new];
        rateVC.drawerController = self.mm_drawerController;
        UINavigationController *rateNavController = [[UINavigationController alloc] initWithRootViewController:rateVC];
        [self.mm_drawerController setCenterViewController:rateNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (indexPath.row == 4) {
        PremiumUpgradeViewController *premiumVC = [PremiumUpgradeViewController new];
        premiumVC.drawerController = self.mm_drawerController;
        UINavigationController *premiumUpgradeNavController = [[UINavigationController alloc] initWithRootViewController:premiumVC];
        [self.mm_drawerController setCenterViewController:premiumUpgradeNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (indexPath.row == 5) {
        ReferralViewController *referralVC = [ReferralViewController new];
        referralVC.drawerController = self.mm_drawerController;
        UINavigationController *referralNavController = [[UINavigationController alloc] initWithRootViewController:referralVC];
        [self.mm_drawerController setCenterViewController:referralNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (indexPath.row == 6) {
        SettingsMenuViewController *settingsVC = [SettingsMenuViewController new];
        settingsVC.drawerController = self.mm_drawerController;
        UINavigationController *settingsNavController = [[UINavigationController alloc] initWithRootViewController:settingsVC];
        [self.mm_drawerController setCenterViewController:settingsNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }
}


#pragma mark - custom menu cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row == 0) {
//        return 64;
//    }
    if (indexPath.row == 0) {
        return 100;
    } else {
        return 38;
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

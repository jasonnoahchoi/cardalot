//
//  SettingsMenuViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "SettingsMenuViewController.h"
#import "DeckCollectionViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "LegalInformationViewController.h"
#import "RemindersViewController.h"
#import "SupportViewController.h"
#import "AdvancedSettingsViewController.h"
#import "FAQViewController.h"
#import "DeckCollectionViewController.h"

@interface SettingsMenuViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Settings";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    // using icon8 image:  <a href="http://icons8.com/web-app/5771/Appointment-Reminders">Free icons by Icons8</a>
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reminder"] style:UIBarButtonItemStylePlain target:self action:nil]; ////// set action to dropdown alerts from reminders
    
    // Create tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // Datasource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
#pragma mark - sets static settings cells
    self.advancedSettingsCell = [UITableViewCell new];
    self.advancedSettingsCell.textLabel.text = @"Advanced Settings";
    self.advancedSettingsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.reminderCell = [UITableViewCell new];
    self.reminderCell.textLabel.text = @"Reminders";
    self.reminderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.howToUseCell = [UITableViewCell new];
    self.howToUseCell.textLabel.text = @"FAQ";
    self.howToUseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.supportCell = [UITableViewCell new];
    self.supportCell.textLabel.text = @"Support";
    self.supportCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.legalCell = [UITableViewCell new];
    self.legalCell.textLabel.text = @"Legal";
    self.legalCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.versionCell = [UITableViewCell new];
    self.versionLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.versionCell.contentView.bounds, 15, 0)];
    self.versionLabel.text = @"Version ";
    self.versionCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.versionCell addSubview:self.versionLabel];
    
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
        case 0:  return 2;  // section 0 has 2 rows
        case 1:  return 2;  // section 1 has 2 row
        case 2: return 2;  // section 2 has 2 row
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
            case 0: return self.reminderCell;
            case 1: return self.advancedSettingsCell;
        }
        case 1:
            switch(indexPath.row) {
            case 0: return self.howToUseCell;
            case 1: return self.supportCell;
        }
        case 2:
            switch (indexPath.row) {
            case 0: return self.legalCell;
            case 1: return self.versionCell;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UINavigationController *navigationController = (UINavigationController *)self.mm_drawerController.centerViewController;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RemindersViewController *reminderVC = [RemindersViewController new];
//            reminderVC.drawerController = self.mm_drawerController;
            UINavigationController *reminderNavController = [[UINavigationController alloc] initWithRootViewController:reminderVC];
//            [self.mm_drawerController setCenterViewController:reminderNavController];
//            [navigationController popToRootViewControllerAnimated:YES];
//            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            [self presentViewController:reminderNavController animated:YES completion:nil];
        } else if (indexPath.row == 1) {
            AdvancedSettingsViewController *advancedSettingVC = [AdvancedSettingsViewController new];
//            advancedSettingVC.drawerController = self.mm_drawerController;
            UINavigationController *advancedSettingNavController = [[UINavigationController alloc] initWithRootViewController:advancedSettingVC];
//            [self.mm_drawerController setCenterViewController:advancedSettingNavController];
//            [navigationController popToRootViewControllerAnimated:YES];
//            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            [self presentViewController:advancedSettingNavController animated:YES completion:nil];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            FAQViewController *faqVC = [FAQViewController new];
//            faqVC.drawerController = self.mm_drawerController;
            UINavigationController *faqNavController = [[UINavigationController alloc] initWithRootViewController:faqVC];
//            [self.mm_drawerController setCenterViewController:faqNavController];
//            [navigationController popToRootViewControllerAnimated:YES];
//            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            [self presentViewController:faqNavController animated:YES completion:nil];
        } else if (indexPath.row == 1) {
            SupportViewController *supportVC = [SupportViewController new];
//            supportVC.drawerController = self.mm_drawerController;
            UINavigationController *supportNavController = [[UINavigationController alloc] initWithRootViewController:supportVC];
//            [self.mm_drawerController setCenterViewController:supportNavController];
//            [navigationController popToRootViewControllerAnimated:YES];
//            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            [self presentViewController:supportNavController animated:YES completion:nil];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            LegalInformationViewController *legalVC = [LegalInformationViewController new];
//            legalVC.drawerController = self.mm_drawerController;
            UINavigationController *legalNavController = [[UINavigationController alloc] initWithRootViewController:legalVC];
//            [self.mm_drawerController setCenterViewController:legalNavController];
//            [navigationController popToRootViewControllerAnimated:YES];
//            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            [self presentViewController:legalNavController animated:YES completion:nil];
        }
    }
}

// Sets the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section) {
        case 0: return @"Settings";
        case 1: return @"Help";
        case 2: return @"About";
    }
    return nil;
}

- (void)goBack {
    DeckCollectionViewController *deckCollectionVC = [[DeckCollectionViewController alloc] init];
    deckCollectionVC.drawerController = self.drawerController;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:deckCollectionVC];
    [self.drawerController setCenterViewController:navController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

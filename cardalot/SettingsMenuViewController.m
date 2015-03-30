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
#import "CardViewController.h"
@import WebKit;

@interface SettingsMenuViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *faqContainerView;

@end

@implementation SettingsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Settings";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    // using icon8 image:  <a href="http://icons8.com/web-app/5771/Appointment-Reminders">Free icons by Icons8</a>
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCard)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    // Create tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // Datasource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
#pragma mark - sets static settings cells
//    self.advancedSettingsCell = [UITableViewCell new];
//    self.advancedSettingsCell.textLabel.text = @"Advanced Settings";
//    self.advancedSettingsCell.selectionStyle = UITableViewCellSelectionStyleNone;
   
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
    UILabel *versionNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    versionNumber.text = @"1.0";
    versionNumber.textColor = [UIColor lightGrayColor];
    self.versionCell.accessoryView = versionNumber;
    
    // Disable/Enable selection
    self.tableView.allowsSelection = YES;
    
    // Add to view
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
//        case 0:  return 1;  // section 0 has 2 rows
        case 0:  return 2;  // section 1 has 2 row
        case 1: return 2;  // section 2 has 2 row
        default: return 0;
    };
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

//    cell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
//    NSAttributedString *attText = [[NSAttributedString alloc]initWithString:menuListArray[indexPath.row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Marion-Bold" size:16]}];
//    cell.textLabel.attributedText = attText;

    switch(indexPath.section) {
//        case 0:
//            switch(indexPath.row) {
//            case 0: return self.reminderCell;
//            case 1: return self.advancedSettingsCell;
//        }
        case 0:
            switch(indexPath.row) {
            case 0: return self.howToUseCell;
            case 1: return self.supportCell;
        }
        case 1:
            switch (indexPath.row) {
            case 0: return self.legalCell;
            case 1: return self.versionCell;
        }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UINavigationController *navigationController = (UINavigationController *)self.mm_drawerController.centerViewController;
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            RemindersViewController *reminderVC = [RemindersViewController new];
////            reminderVC.drawerController = self.mm_drawerController;
//            UINavigationController *reminderNavController = [[UINavigationController alloc] initWithRootViewController:reminderVC];
////            [self.mm_drawerController setCenterViewController:reminderNavController];
////            [navigationController popToRootViewControllerAnimated:YES];
////            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
//            [self presentViewController:reminderNavController animated:YES completion:nil];
//        } else if (indexPath.row == 1) {
//            AdvancedSettingsViewController *advancedSettingVC = [AdvancedSettingsViewController new];
////            advancedSettingVC.drawerController = self.mm_drawerController;
//            UINavigationController *advancedSettingNavController = [[UINavigationController alloc] initWithRootViewController:advancedSettingVC];
////            [self.mm_drawerController setCenterViewController:advancedSettingNavController];
////            [navigationController popToRootViewControllerAnimated:YES];
////            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
//            [self presentViewController:advancedSettingNavController animated:YES completion:nil];
//        }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            FAQViewController *faqVC = [FAQViewController new];
//            UINavigationController *faqNavController = [[UINavigationController alloc] initWithRootViewController:faqVC];
//            [self presentViewController:faqNavController animated:YES completion:nil];
            self.faqContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:self.faqContainerView];
            WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 92)];
            NSString *htmlForView = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"FAQ" withExtension:@"html"] encoding:NSStringEncodingConversionAllowLossy error:nil];
            [webView loadHTMLString:htmlForView baseURL:[[NSBundle mainBundle] URLForResource:@"FAQ" withExtension:@"html"]];
            
            UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [dismissButton setImage:[UIImage imageNamed:@"deletecircle"] forState:UIControlStateNormal];
            dismissButton.frame = CGRectMake(CGRectGetMaxX(self.faqContainerView.frame) - 40, 32, 30, 30);
            [dismissButton addTarget:self action:@selector(dismissFAQView) forControlEvents:UIControlEventTouchUpInside];
            
            [self.faqContainerView addSubview:webView];
            [self.faqContainerView addSubview:dismissButton];
        
            
        } else if (indexPath.row == 1) {
            SupportViewController *supportVC = [SupportViewController new];
//            supportVC.drawerController = self.mm_drawerController;
            UINavigationController *supportNavController = [[UINavigationController alloc] initWithRootViewController:supportVC];
//            [self.mm_drawerController setCenterViewController:supportNavController];
//            [navigationController popToRootViewControllerAnimated:YES];
//            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            [self presentViewController:supportNavController animated:YES completion:nil];
        }
    } else if (indexPath.section == 1) {
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
//        case 0: return @"Settings";
        case 0: return @"Help";
        case 1: return @"About";
    }
    return nil;
}

- (void)open {
    if (self.drawerController.openSide) {
        [self.drawerController closeDrawerAnimated:YES completion:nil];
    } else {
        [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

- (void)addCard {
    CardViewController *cardVC = [[CardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];
}

- (void)dismissFAQView {
    [self.faqContainerView removeFromSuperview];
}

@end

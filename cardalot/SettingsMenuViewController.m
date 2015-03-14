//
//  SettingsMenuViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "SettingsMenuViewController.h"
#import "DeckCollectionViewController.h"
#import <MMDrawerController.h>

@interface SettingsMenuViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Settings";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    
    // Create tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // Datasource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Background Color of TableView
//    self.tableView.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
    
    
#pragma mark - sets static settings cells
    self.advancedSettingsCell = [UITableViewCell new];
    self.advancedSettingsCell.textLabel.text = @"Advanced Settings";
    
    self.reminderCell = [UITableViewCell new];
    self.reminderCell.textLabel.text = @"Reminders";
    
    self.howToUseCell = [UITableViewCell new];
    self.howToUseCell.textLabel.text = @"FAQ";
    
    self.supportCell = [UITableViewCell new];
    self.supportCell.textLabel.text = @"Support";
    
    self.legalCell = [UITableViewCell new];
    self.legalCell.textLabel.text = @"Legal";
    
    self.versionCell = [UITableViewCell new];
    
    
    
    // Add to view
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section)
    {
        case 0:  return 1;  // section 0 has 1 rows
        case 1:  return 1;  // section 1 has 1 row
        case 2: return 1;  // section 2 has 1 row
        default: return 0;
    };
    
//    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSArray *menuListArray = @[@"Advanced Settings", @"Support", @"Legal"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    cell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
//    NSAttributedString *attText = [[NSAttributedString alloc]initWithString:menuListArray[indexPath.row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Marion-Bold" size:16]}];
//    cell.textLabel.attributedText = attText;
//    // removes highlighting of cells when selecting
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
    
    switch(indexPath.section)
    {
        case 0:
            switch(indexPath.row)
        {
            case 0: return self.advancedSettingsCell;  // section 0, row 0 is advanced settings
        }
        case 1:
            switch(indexPath.row)
        {
            case 0: return self.supportCell;      // section 1, row 0 is support
        }
        case 2:
            switch (indexPath.row)
        {
            case 0: return self.legalCell;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// Sets the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section)
    {
        case 0: return @"Settings";
        case 1: return @"Help";
        case 2: return @"About";
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

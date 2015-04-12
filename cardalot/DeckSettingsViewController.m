//
//  DeckSettingsViewController.m
//  cardalot
//
//  Created by sombra on 2015-04-11.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckSettingsViewController.h"
#import "DeckSettingsDataSource.h"
#import "UIColor+Colors.h"

@interface DeckSettingsViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DeckSettingsDataSource *dataSource;

@end

@implementation DeckSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSubview];
    [self loadNavigationBar];
}

- (void)layoutSubview {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.dataSource = [[DeckSettingsDataSource alloc] initWithDeck:self.deck];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
}

- (void)loadNavigationBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark - IBAction

- (IBAction)doneButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

//
//  StatsViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-12.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StatsViewController.h"
#import "StatsTableViewDataSource.h"
#import "DeckCollectionViewController.h"
#import <MMDrawerController.h>

@interface StatsViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) StatsTableViewDataSource *dataSource;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"History/Stats";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.rowHeight = 150;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    self.dataSource = [[StatsTableViewDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
}

- (void)open {
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end

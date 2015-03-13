//
//  StatsViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-12.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StatsViewController.h"
#import "StatsTableViewDataSource.h"

@interface StatsViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) StatsTableViewDataSource *dataSource;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    
    self.dataSource = [[StatsTableViewDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
}

@end

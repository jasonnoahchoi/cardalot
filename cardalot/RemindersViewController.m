//
//  RemindersViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-14.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "RemindersViewController.h"
#import "RemindersTableViewDataSource.h"

@interface RemindersViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RemindersTableViewDataSource *dataSource;

@end

@implementation RemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    self.dataSource = [[RemindersTableViewDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
}

@end

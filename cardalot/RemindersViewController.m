//
//  RemindersViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-14.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "RemindersViewController.h"

@interface RemindersViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
}

@end

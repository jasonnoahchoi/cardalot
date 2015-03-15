//
//  RemindersTableViewDataSource.m
//  cardalot
//
//  Created by sombra on 2015-03-14.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "RemindersTableViewDataSource.h"

static NSString * const cellIdentifier = @"cell";

@interface RemindersTableViewDataSource ()

@property (strong, nonatomic) NSMutableArray *reminders;

@end

@implementation RemindersTableViewDataSource

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reminders.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    NSInteger index = self.reminders.count;
    if (indexPath.row == index) {
        cell.textLabel.text = @"Add Reminder";
    }
    
    return cell;
}

@end

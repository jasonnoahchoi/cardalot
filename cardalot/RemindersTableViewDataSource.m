//
//  RemindersTableViewDataSource.m
//  cardalot
//
//  Created by sombra on 2015-03-14.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "RemindersTableViewDataSource.h"
#import "CustomDatePickerView.h"

static NSString * const cellIdentifier = @"cell";

@interface RemindersTableViewDataSource ()

@property (assign, nonatomic) NSInteger reminders;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RemindersTableViewDataSource

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addReminder:) name:@"DateSelected" object:nil];
    }
    
    return self;
}

- (void)registerTableView:(UITableView *)tableView {
    self.tableView = tableView;
    self.tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reminders + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    NSInteger index = self.reminders;
    if (indexPath.row == index) {
        cell.textLabel.text = @"Add Reminder";
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == self.reminders) {
        CustomDatePickerView *datePickerView = [[CustomDatePickerView alloc] initWithFrame:CGRectMake(45, -280, 280, 250)]; // 6
        //    CustomDatePickerView *datePickerView = [[CustomDatePickerView alloc] initWithFrame:CGRectMake(20, -280, 280, 250)]; // 5/5s/4s
        //    CustomDatePickerView *datePickerView = [[CustomDatePickerView alloc] initWithFrame:CGRectMake(65, -280, 280, 250)]; // 6+
        [self.tableView addSubview:datePickerView];
        [UIView animateWithDuration:1.0 animations:^{
            datePickerView.center = CGPointMake(datePickerView.center.x, datePickerView.center.y + 433);
        }]; // 6
        //    [UIView animateWithDuration:1.0 animations:^{
        //        datePickerView.center = CGPointMake(datePickerView.center.x, datePickerView.center.y + 380);
        //    }]; // 4s/5/5s
        //    [UIView animateWithDuration:1.0 animations:^{
        //        datePickerView.center = CGPointMake(datePickerView.center.x, datePickerView.center.y + 500);
        //    }]; // 6+
    }
}

#pragma mark Action
- (void)addReminder:(NSNotification *)notification {
    self.reminders++;
    [self.tableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.reminders - 1) inSection:0];
    
    NSDictionary *userInfo = notification.userInfo;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSDate *date = userInfo[@"selectedDate"];
    NSString *frequency = userInfo[@"frequency"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ at %@", frequency, [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle]];
}

@end

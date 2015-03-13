//
//  StatsTableViewDataSource.m
//  cardalot
//
//  Created by sombra on 2015-03-12.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StatsTableViewDataSource.h"
#import "StatsTableViewCell.h"

static NSString * const cellIdentifier = @"cell";

@implementation StatsTableViewDataSource

- (void)registerTableView:(UITableView *)tableView {

    [tableView registerNib:[UINib nibWithNibName:@"StatsTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

@end

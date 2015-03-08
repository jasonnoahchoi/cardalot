//
//  CardViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardViewController.h"



@interface CardViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set Title of card
    self.title = @"Card View";
    
    
    // Create Tableview
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // Dismissing Keyboard on touch/scroll
    [self.view endEditing:YES];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    self.tableView.allowsSelection = NO;
    
    // DataSource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.72 green:0.74 blue:0.7 alpha:1];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
        cell.backgroundColor = [UIColor colorWithRed:0.72 green:0.74 blue:0.7 alpha:1];
        return cell;
    } else if (indexPath.row == 1) {
        DeckTagCell *cell = [[DeckTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        return cell;
    } else if (indexPath.row == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell3"];
        cell.backgroundColor = [UIColor colorWithRed:0.72 green:0.74 blue:0.7 alpha:1];
        return cell;
    } else if (indexPath.row == 3) {
        FrontTextCell *cell = [[FrontTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell4"];
        return cell;
    } else if (indexPath.row == 4) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell5"];
        cell.backgroundColor = [UIColor colorWithRed:0.72 green:0.74 blue:0.7 alpha:1];
        return cell;
    } else {
        BackTextCell *cell = [[BackTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell6"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 30;
    } else if (indexPath.row == 1) {
        return 44;
    } else if (indexPath.row == 2) {
        return 30;
    } else if (indexPath.row == 3) {
        return 100;
    } else if (indexPath.row == 4) {
        return 30;
    } else {
        return 300;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

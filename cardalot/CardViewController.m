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
    self.title = @"Study Card";
    
    // Create Tableview
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // Dismissing Keyboard on touch/scroll
    [self.view endEditing:YES];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    // Disable selection of cells highlighting
    self.tableView.allowsSelection = NO;
    
    // DataSource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    // sets background color
    self.tableView.backgroundColor = [UIColor colorWithRed:0.79 green:0.88 blue:0.91 alpha:1];
    
    // adds right bar button item
    UINavigationItem *navigationSaveItem = self.navigationItem;
    navigationSaveItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissAnimated:)];     // will want to dismiss to detail card collection view
    
    // adjust view for keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    
    // add to view
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
        cell.backgroundColor = [UIColor colorWithRed:0.79 green:0.88 blue:0.91 alpha:1];
        return cell;
    } else if (indexPath.row == 1) {
        DeckTagCell *cell = [[DeckTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        return cell;
    } else if (indexPath.row == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell3"];
        cell.backgroundColor = [UIColor colorWithRed:0.79 green:0.88 blue:0.91 alpha:1];
        return cell;
    } else if (indexPath.row == 3) {
        FrontTextCell *cell = [[FrontTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell4"];
        return cell;
    } else if (indexPath.row == 4) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell5"];
        cell.backgroundColor = [UIColor colorWithRed:0.79 green:0.88 blue:0.91 alpha:1];
        return cell;
    } else {
        BackTextCell *cell = [[BackTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell6"];
        return cell;
    }
}

#pragma mark - custom cell heights
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 30;
    } else if (indexPath.row == 1) {
        return 50;
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

#pragma mark - adjust view for keyboard
- (void)keyboardDidShow:(NSNotification *)notification {
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setFrame:CGRectMake(0,-100,320,560)];
    } else {
        [self.view setFrame:CGRectMake(0,-100,320,460)];
    }
}

-(void)keyboardDidHide:(NSNotification *)notification {
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setFrame:CGRectMake(0,20,320,560)];
    } else {
        [self.view setFrame:CGRectMake(0,20,320,460)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

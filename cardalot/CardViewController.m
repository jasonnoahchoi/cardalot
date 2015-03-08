//
//  CardViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardViewController.h"



@interface CardViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end



@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set Title of card
    
    
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
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
    
    if (indexPath.row == 0) {
        DeckTagCell *cell = [[DeckTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
        return cell;
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        return cell;
    } else if (indexPath.row == 2) {
        FrontTextCell *cell = [[FrontTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell3"];
        return cell;
    } else if (indexPath.row == 3) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell4"];
        return cell;
    } else {
        BackTextCell *cell = [[BackTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell5"];
        return cell;
    }
    

    // ATTEMPT 3
//    DeckTagCell *cell1 = (DeckTagCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (indexPath.row == 0) {
//        cell1 = [[DeckTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    FrontTextCell *cell2 = (FrontTextCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (indexPath.row % 2 == 2) {
//        cell2 = [[FrontTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    BackTextCell *cell3 = (BackTextCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (indexPath.row % 3 == 3) {
//        cell3 = [[BackTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    return Cell1;
//    return Cell2;
//    return Cell3;



}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 44;
    } else if (indexPath.row == 1) {
        return 44;
    } else if (indexPath.row == 2) {
        return 100;
    } else if (indexPath.row == 3) {
        return 44;
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

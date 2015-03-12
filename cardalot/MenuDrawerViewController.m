//
//  MenuDrawerViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "MenuDrawerViewController.h"

@interface MenuDrawerViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LogoMenuCell *logoMenuCell;
@property (nonatomic, strong) SearchCell *searchCell;

@end

@implementation MenuDrawerViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.contentOffset = CGPointMake(0, self.searchCell.frame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set title
    self.title = @"Cardalot";
    
    // Create tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // Dismiss keyboard on scroll
    [self.view endEditing:YES];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    // Disable/Enable selection cell highlight
    self.tableView.allowsSelection = NO;
    
    // Removes seperator lines
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Datasource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Background Color of TableView
    self.tableView.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
    

    // Add to view
    [self.view addSubview:self.tableView];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        self.searchCell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
        self.searchCell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
        return self.searchCell;
    } else if (indexPath.row == 1) {
        self.logoMenuCell = [[LogoMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        return self.logoMenuCell;
    } else {  // for string with format add the itentifier for account type
        NSArray *menuListArray = @[[NSString stringWithFormat:@"Account Type: "], @"Quiz History", @"Rate App", @"Go Premium", @"Refer Friends", @"Support Email", @"Attributions", @"Privacy Policy", @"Terms of Service"];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
//        [self.navigationController presentViewController:[PremiumUpgradeViewController] animated:YES completion:nil];
        
        cell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
        NSAttributedString *attText = [[NSAttributedString alloc]initWithString:menuListArray[indexPath.row - 2] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Marion-Bold" size:16]}];
  
        cell.textLabel.attributedText = attText;
        
        return cell;
    }
}


#pragma mark - custom menu cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 64;
    } else if (indexPath.row == 1) {
        return 100;
    } else {
        return 38;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  CardViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardViewController.h"
#import "DeckController.h"
#import "CustomInputAccessoryView.h"
#import "UIBarButtonItem+CustomButtons.h"
#import "UIColor+Colors.h"

@interface CardViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DeckTagCell *deckTagCell;
@property (nonatomic, strong) FrontTextCell *frontTextCell;
@property (nonatomic, strong) BackTextCell *backTextCell;
@property (nonatomic, strong) CustomInputAccessoryView *accessoryView;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self layoutNavBarItems];

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
    
    // add to view
    [self.view addSubview:self.tableView];
}

- (void)layoutNavBarItems {
    // Set Title of card
    self.title = @"Study Card";

    UIImage *image = [UIImage imageNamed:@"backbutton"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backButtonWithImage:image target:self action:@selector(backButtonAction)];

    // adds right bar button item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];     // will want to dismiss to detail card collection view
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor customBlueColor]];

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
        self.deckTagCell = [[DeckTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        return self.deckTagCell;
    } else if (indexPath.row == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell3"];
        cell.backgroundColor = [UIColor colorWithRed:0.79 green:0.88 blue:0.91 alpha:1];
        return cell;
    } else if (indexPath.row == 3) {
        self.frontTextCell = [[FrontTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell4"];
        return self.frontTextCell;
    } else if (indexPath.row == 4) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell5"];
        cell.backgroundColor = [UIColor colorWithRed:0.79 green:0.88 blue:0.91 alpha:1];
        return cell;
    } else {
        self.backTextCell = [[BackTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell6"];
        self.accessoryView = [[CustomInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        self.backTextCell.backTextView.inputAccessoryView = self.accessoryView;
        self.accessoryView.delegate = self.backTextCell.backTextView;
        return self.backTextCell;
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

#pragma mark IBAction
- (IBAction)done:(id)sender {
    [[DeckController sharedInstance] addCardWithTitle:self.frontTextCell.frontTextField.text andAnswer:self.backTextCell.backTextView.text toDeckWithNameTag:self.deckTagCell.deckTagField.text];
    [[DeckController sharedInstance] save];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

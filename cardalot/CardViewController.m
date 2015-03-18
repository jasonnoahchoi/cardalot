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
#import "Deck.h"

@interface CardViewController () <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DeckTagCell *deckTagCell;
@property (nonatomic, strong) FrontTextCell *frontTextCell;
@property (nonatomic, strong) BackTextCell *backTextCell;
@property (nonatomic, strong) CustomInputAccessoryView *accessoryView;
@property (nonatomic, strong) NSMutableArray *cells;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCells];

    [self layoutNavBarItems];

    // Create Tableview
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // Dismissing Keyboard on touch/scroll
    [self.view endEditing:YES];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

    // Disable selection of cells highlighting
    self.tableView.allowsSelection = YES;
    
    // DataSource
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    // sets background color
    self.tableView.backgroundColor = [UIColor customBlueColor];

    [self checkTextFields];

    // add to view
    [self.view addSubview:self.tableView];
}

- (void)createCells {
    self.cells = [[NSMutableArray alloc] init];
    
    UITableViewCell *cellOne = [[UITableViewCell alloc] init];
    cellOne.backgroundColor = [UIColor customBlueColor];
    [self.cells addObject:cellOne];
    
    self.deckTagCell = [[DeckTagCell alloc] init];
    self.deckTagCell.deckTagField.delegate = self;
    if (self.deck) {
        self.deckTagCell.deckTagField.text = self.deck.nameTag;
    }
    [self.cells addObject:self.deckTagCell];
    
    UITableViewCell *cellTwo = [[UITableViewCell alloc] init];
    cellTwo.backgroundColor = [UIColor customBlueColor];
    [self.cells addObject:cellTwo];
    
    self.frontTextCell = [[FrontTextCell alloc] init];
    self.frontTextCell.frontTextField.delegate = self;
    [self.cells addObject:self.frontTextCell];
    
    UITableViewCell *cellThree = [[UITableViewCell alloc] init];
    cellThree.backgroundColor = [UIColor customBlueColor];
    [self.cells addObject:cellThree];
    
    self.backTextCell = [[BackTextCell alloc] init];
    self.accessoryView = [[CustomInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.backTextCell.backTextView.inputAccessoryView = self.accessoryView;
    self.accessoryView.delegate = self.backTextCell.backTextView;
    self.backTextCell.backTextView.delegate = self;
    [self.cells addObject:self.backTextCell];
}

- (void)layoutNavBarItems {
    // Set Title of card
    self.title = @"Add Card";

    UIImage *image = [UIImage imageNamed:@"backbutton"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backButtonWithImage:image target:self action:@selector(backButtonAction)];

    // adds right bar button item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];     // will want to dismiss to detail card collection view
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}


#pragma mark - Helper Method
// check if empty
- (void)checkTextFields {
    if ([self.backTextCell.backTextView.text isEqualToString:@""] || self.backTextCell.backTextView.text == nil || [self.deckTagCell.deckTagField.text isEqualToString:@""] || self.deckTagCell.deckTagField.text == nil || [self.frontTextCell.frontTextField.text isEqualToString:@""] || self.frontTextCell.frontTextField.text == nil) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    } else {
//    if ([self.backTextCell.backTextView.text isEqualToString:@""] || self.backTextCell.backTextView.text == nil || [self.deckTagCell.deckTagField.text isEqualToString:@""] || self.deckTagCell.deckTagField.text == nil || [self.frontTextCell.frontTextField.text isEqualToString:@""] || self.frontTextCell.frontTextField.text == nil) {

    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
    //[self.backTextCell.backTextView.text up]
    NSLog(@"%@", self.backTextCell.backTextView.text);
}

- (void)textViewDidChange:(UITextView *)textView {
    [self checkTextFields];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self checkTextFields];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cells[indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

#pragma mark - Delegate Method
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//    float verticalContentOffset  = tableView.contentOffset.y;
//
//    [tableView setContentOffset:CGPointMake(0, verticalContentOffset + 300)];
    
//        CGPoint tableViewCenter = [tableView contentOffset];
//        tableViewCenter.y += tableView.frame.size.height/2;

//        [tableView setContentOffset:CGPointMake(0, cell.center.y + 300) animated:YES];
//        [tableView reloadData];
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Navigation Methods
- (IBAction)done:(id)sender {
    [[DeckController sharedInstance] addCardWithTitle:self.frontTextCell.frontTextField.text andAnswer:self.backTextCell.backTextView.text toDeckWithNameTag:self.deckTagCell.deckTagField.text];
    [[DeckController sharedInstance] save];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end

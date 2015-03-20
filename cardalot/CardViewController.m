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
#import "StorePurchaseController.h"
#import "PurchasedDataController.h"
@import StoreKit;

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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [self checkTextFields];
    
    CGRect caret = [textView caretRectForPosition:textView.selectedTextRange.end];
    CGPoint contentOffset = CGPointMake(0, CGRectGetMaxY(caret) + 120);
    if ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480) {
        if (contentOffset.y < CGRectGetMaxY(textView.frame) + 50) {
            [self.tableView setContentOffset:contentOffset animated:YES];
        }
    } else if ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 568) {
        if (contentOffset.y < CGRectGetMaxY(textView.frame)) {
            [self.tableView setContentOffset:contentOffset animated:YES];
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    CGPoint pointInTable = [textView.superview convertPoint:textView.frame.origin toView:self.tableView];
    CGPoint contentOffset = self.tableView.contentOffset;
    
    contentOffset.y = (pointInTable.y - textView.inputAccessoryView.frame.size.height) - 60;
    
    NSLog(@"contentOffset is: %@", NSStringFromCGPoint(contentOffset));
    
    [self.tableView setContentOffset:contentOffset animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.superview.superview isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = (UITableViewCell*)textView.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self checkTextFields];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint pointInTable = [textField.superview convertPoint:textField.frame.origin toView:self.tableView];
    CGPoint contentOffset = self.tableView.contentOffset;
    
    contentOffset.y = (pointInTable.y - textField.inputAccessoryView.frame.size.height) - 100;
    
    NSLog(@"contentOffset is: %@", NSStringFromCGPoint(contentOffset));
    
    [self.tableView setContentOffset:contentOffset animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.deckTagCell.deckTagField) {
        [self.frontTextCell.frontTextField becomeFirstResponder];
    }
    if (textField == self.frontTextCell.frontTextField) {
        [self.backTextCell.backTextView becomeFirstResponder];
    }
    return YES;
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cells[indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

#pragma mark - UITableViewDelegate Method
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
    if ( [DeckController sharedInstance].decks.count >= 5 && [PurchasedDataController sharedInstance].goPro == NO && ![[DeckController sharedInstance].nameTags containsObject:self.deckTagCell.deckTagField.text]) {
        UIAlertController *deckLimitAlert = [UIAlertController alertControllerWithTitle:@"You've reached your limit!" message:@"You can get unlimited decks with more features coming soon by upgrading to our pro version!" preferredStyle:UIAlertControllerStyleAlert];
        [deckLimitAlert addAction:[UIAlertAction actionWithTitle:@"Go Pro" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[StorePurchaseController sharedInstance] purchaseOptionSelectedObjectIndex:0];
        }]];

        [deckLimitAlert addAction:[UIAlertAction actionWithTitle:@"No, thanks" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Not buying pro");
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:deckLimitAlert animated:YES completion:nil];
    }
    [[DeckController sharedInstance] save];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end

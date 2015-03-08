//
//  BackTextCell.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "BackTextCell.h"

@implementation BackTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGSize size = self.contentView.frame.size;
        
        // position/size
        self.backTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, size.width - 10.0, size.height + 200.0)];
        
        // modification
        self.backTextView.font = [UIFont boldSystemFontOfSize:16.0];
        self.backTextView.tintColor = [UIColor blackColor];
        
        
        
        // add to view
        [self.contentView addSubview:self.backTextView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.backTextView resignFirstResponder];
    
    return YES;
}

    // Attempt at getting content to adjust up for keyboard - not working properly 
- (void)keyboardWasShown:(NSNotification *)notification {
    if (self.backTextView != nil) {
        NSDictionary *info = [notification userInfo];
        CGRect keyboardRect = [self.backTextView convertRect:[[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
        CGSize keyboardSize = keyboardRect.size;
        
        self.backTextView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
        self.backTextView.scrollIndicatorInsets = self.backTextView.contentInset;
    }
}



@end

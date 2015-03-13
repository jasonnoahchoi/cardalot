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
        // position/size
        self.backTextView = [[UITextView alloc] init];
        
        // modification
        self.backTextView.font = [UIFont boldSystemFontOfSize:16.0];
        self.backTextView.textColor = [UIColor blackColor];
        self.backTextView.layer.borderWidth = 1.0f;
        self.backTextView.layer.cornerRadius = 8.0;
        self.backTextView.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] CGColor];
        [self.backTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        // setting delegate
        self.backTextView.delegate = self;
        
        // add to view
        [self.contentView addSubview:self.backTextView];
        
        // AUTOLAYOUT
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.backTextView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:topConstraint];
        
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.backTextView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:leadingConstraint];
        
        NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.backTextView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:trailingConstraint];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.backTextView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:bottomConstraint];
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

#pragma mark - textView placeholder text
//-(void)textViewDidBeginEditing:(UITextView *)textView {
//    if ([textView.text isEqualToString:@”TextView Placeholder Text”]) {
//        textView.text = @”“;
//        textView.textColor = [UIColor lightGrayColor];
//    }
//    [textView becomeFirstResponder];
//}
//
//-(void)textViewDidEndEditing:(UITextView *)textView {
//    if ([textView.text isEqualToString:@”“]) {
//        textView.text = @”TextView Placeholder Text”;
//        textView.textColor = [UIColor lightGrayColor];
//    }
//    [textView resignFirstResponder];
//}


@end

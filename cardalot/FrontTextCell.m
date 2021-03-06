//
//  frontTextCell.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "FrontTextCell.h"
#import "UIColor+Colors.h"

@implementation FrontTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.frontTextField = [[UITextField alloc] init];

        self.frontTextField.font = [UIFont boldSystemFontOfSize:16.0];
        self.frontTextField.placeholder = @"front of card text";
        [self.frontTextField.layer setBorderColor:[UIColor customBlueColor].CGColor];
        [self.frontTextField.layer setBorderWidth:1.0f];
        self.frontTextField.layer.cornerRadius = 5;
        self.frontTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.frontTextField.textAlignment = NSTextAlignmentCenter;
        self.frontTextField.returnKeyType = UIReturnKeyNext;
        self.frontTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.frontTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addSubview:self.frontTextField];

        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.frontTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:topConstraint];
        
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.frontTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:leadingConstraint];
        
        NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.frontTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:trailingConstraint];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.frontTextField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:bottomConstraint];
    }

    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.frontTextField resignFirstResponder];
    
    return YES;
}

@end

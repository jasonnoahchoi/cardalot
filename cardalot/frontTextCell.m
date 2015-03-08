//
//  frontTextCell.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "FrontTextCell.h"

@implementation FrontTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGSize size = self.contentView.frame.size;
        
        // position/size
        self.frontTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, size.width + 30, size.height + 30)];
        
        // modification
        self.frontTextField.font = [UIFont boldSystemFontOfSize:16.0];
        self.frontTextField.tintColor = [UIColor blackColor];
        self.frontTextField.placeholder = @"front of card text";
        self.frontTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.frontTextField.textAlignment = NSTextAlignmentCenter;
        self.frontTextField.returnKeyType = UIReturnKeyNext;
        self.frontTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        // add to view
        [self.contentView addSubview:self.frontTextField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.frontTextField resignFirstResponder];
    
    return YES;
}

@end

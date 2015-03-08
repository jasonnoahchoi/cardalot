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
        self.frontTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, size.width - 20.0, size.height - 20.0)];
        
        // modification
        self.frontTextView.font = [UIFont boldSystemFontOfSize:16.0];
        self.frontTextView.tintColor = [UIColor blackColor];
        
        
        
        
        // add to view
        [self.contentView addSubview:self.frontTextView];
    }
    return self;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if(textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if([textView.text length] == 0) {
        textView.text = @"front of card text here";
        textView.textColor = [UIColor lightGrayColor];
        textView.tag = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.frontTextView resignFirstResponder];
    
    return YES;
}

@end

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
        self.frontTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, size.width - 10.0, size.height + 30)];
        
        // modification
        self.frontTextView.font = [UIFont boldSystemFontOfSize:16.0];
        self.frontTextView.tintColor = [UIColor blackColor];
        
        // add to view
        [self.contentView addSubview:self.frontTextView];
    }
    return self;
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

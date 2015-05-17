//
//  SearchCell.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.searchField = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 180, 44)];

        self.searchField.backgroundColor = [UIColor lightGrayColor];
        [self.searchField setBackgroundImage:[UIImage new]];
        [self.searchField setTranslucent:YES];

        self.searchField.delegate = self;

        [self.contentView addSubview:self.searchField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchField resignFirstResponder];
    
    return YES;
}

@end

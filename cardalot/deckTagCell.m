//
//  DeckTagCell.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckTagCell.h"

@implementation DeckTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // label/field position/size
        self.hashTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 35, 30)];
        
        self.deckTagField = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 260, 30)];
        
        // label/field modification
        self.hashTagLabel.text = @"#";
        [self.hashTagLabel setFont:[UIFont boldSystemFontOfSize:26.0]];
        [self.hashTagLabel setTextAlignment:NSTextAlignmentCenter];
        [self.hashTagLabel setTextColor:[UIColor blackColor]];
        
        self.deckTagField.placeholder = @"name category of cards";
        self.deckTagField.font = [UIFont boldSystemFontOfSize:18.0];
        self.deckTagField.tintColor = [UIColor blackColor];
        self.deckTagField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.deckTagField.returnKeyType = UIReturnKeyNext;
        
        // Add to View
        [self.contentView addSubview:self.hashTagLabel];
        [self.contentView addSubview:self.deckTagField];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.deckTagField endEditing:YES];// this will do the trick
}



@end

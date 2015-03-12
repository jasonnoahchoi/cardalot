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
        self.hashTagLabel = [[UILabel alloc] init];
        
        self.deckTagField = [[UITextField alloc] init];
        
        // label/field modification
        self.hashTagLabel.text = @"#";
        [self.hashTagLabel setFont:[UIFont boldSystemFontOfSize:26.0]];
        [self.hashTagLabel setTextAlignment:NSTextAlignmentCenter];
        [self.hashTagLabel setTextColor:[UIColor blackColor]];
        [self.hashTagLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        self.deckTagField.placeholder = @"name category of cards";
        self.deckTagField.font = [UIFont boldSystemFontOfSize:18.0];
        self.deckTagField.tintColor = [UIColor blackColor];
        self.deckTagField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.deckTagField.returnKeyType = UIReturnKeyNext;
        self.deckTagField.borderStyle = UITextBorderStyleRoundedRect;
        [self.deckTagField setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        // Add to View
        [self.contentView addSubview:self.hashTagLabel];
        [self.contentView addSubview:self.deckTagField];
        
        // AUTOLAYOUT
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_hashTagLabel, _deckTagField);
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_hashTagLabel]-[_deckTagField(>=260)]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.hashTagLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:topConstraint];
        
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.hashTagLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
        [self.contentView addConstraint:leadingConstraint];
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

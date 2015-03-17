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
        //self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"Hashtag 4"];
        [self.contentView addSubview:self.imageView];
//        self.hashTagLabel.text = @"#";
//        [self.hashTagLabel setFont:[UIFont boldSystemFontOfSize:26.0]];
//        [self.hashTagLabel setTextAlignment:NSTextAlignmentCenter];
//        [self.hashTagLabel setTextColor:[UIColor blackColor]];
//        [self.hashTagLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

        self.deckTagField.placeholder = @"Enter Deck Name";
        self.deckTagField.font = [UIFont boldSystemFontOfSize:18.0];
        self.deckTagField.tintColor = [UIColor blackColor];
        self.deckTagField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.deckTagField.returnKeyType = UIReturnKeyNext;
        self.deckTagField.borderStyle = UITextBorderStyleRoundedRect;
        [self.deckTagField setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        // Add to View
//        [self.contentView addSubview:self.hashTagLabel];
        [self.contentView addSubview:self.deckTagField];
        
        // AUTOLAYOUT
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_deckTagField);
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[_deckTagField(>=250)]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        NSArray *constraintsVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_deckTagField]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraintsVertical];

//        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.deckTagField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
//        [self.contentView addConstraint:centerYConstraint];

//        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.hashTagLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
//        [self.contentView addConstraint:topConstraint];
//        
//        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.hashTagLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
//        [self.contentView addConstraint:leadingConstraint];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.deckTagField endEditing:YES];// this will do the trick
}

@end

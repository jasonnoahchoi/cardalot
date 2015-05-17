//
//  DeckTagCell.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckTagCell.h"
#import "UIColor+Colors.h"

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
        self.imageView.image = [UIImage imageNamed:@"Hashtag 4"];
        [self.contentView addSubview:self.imageView];

        self.deckTagField.placeholder = @"Enter Deck Name";
        self.deckTagField.font = [UIFont boldSystemFontOfSize:18.0];
        self.deckTagField.layer.cornerRadius = 3;
        self.deckTagField.layer.borderWidth = 1.0f;
        [self.deckTagField.layer setBorderColor:[UIColor customBlueColor].CGColor];
        self.deckTagField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.deckTagField.returnKeyType = UIReturnKeyNext;
        self.deckTagField.borderStyle = UITextBorderStyleRoundedRect;
        [self.deckTagField setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        // Add to View
        [self.contentView addSubview:self.deckTagField];
        
        // AUTOLAYOUT
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_deckTagField);
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[_deckTagField(>=250)]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        NSArray *constraintsVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_deckTagField]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraintsVertical];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.deckTagField endEditing:YES];// this will do the trick
}

@end

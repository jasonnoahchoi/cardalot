//
//  LogoMenuCell.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "LogoMenuCell.h"

@implementation LogoMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 22, 70, 70)];
        self.decktagLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 160, 20)];

        self.logoImage.image = [UIImage imageNamed:@"logoMenu"];

        self.decktagLabel.text = @"My Decks";
        self.decktagLabel.textColor = [UIColor whiteColor];
        self.decktagLabel.font = [UIFont systemFontOfSize:16.0];

        self.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];

        [self.contentView addSubview:self.logoImage];
        [self.contentView addSubview:self.decktagLabel];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

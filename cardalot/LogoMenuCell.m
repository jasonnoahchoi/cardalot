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
        
        //Position/Size
        self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        
        // inserts image
        self.logoImage.image = [UIImage imageNamed:@"logoMenu"];
        
        // set Delegate
        
        
        // add subview
        [self.contentView addSubview:self.logoImage];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

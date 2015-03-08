//
//  DeckCollectionViewCell.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/7/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckCollectionViewCell.h"
#import "DeckCollectionViewLayout.h"
#import "DeckCollectionViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DeckCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.layer setCornerRadius:10];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 5.0f;
}



@end

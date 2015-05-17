//
//  QuizFrontView.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/13/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "QuizFrontView.h"
#import "UIColor+Colors.h"

@implementation QuizFrontView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor customBlueColor];
        self.frontLabel.backgroundColor = [UIColor customBlueColor];
        self.frontLabel = [UILabel new];
        self.frontLabel.textColor = [UIColor whiteColor];
        self.frontLabel.font = [UIFont boldSystemFontOfSize:32];
        self.frontLabel.text = @"Sample text";
        self.frontLabel.numberOfLines = 0;
        self.frontLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.frontLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.frontLabel];
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 3.0f;
        self.layer.cornerRadius = 3;

        [self.frontLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

        NSLayoutConstraint *centerXLabelInViewConstraint = [NSLayoutConstraint
                                                           constraintWithItem:self.frontLabel
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                           attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                           constant:0];
        [self addConstraint:centerXLabelInViewConstraint];

        NSLayoutConstraint *centerYLabelInViewConstraint = [NSLayoutConstraint
                                                            constraintWithItem:self.frontLabel
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                            attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                            constant:0];
        [self addConstraint:centerYLabelInViewConstraint];



        NSArray *constraint = [NSLayoutConstraint
                                         constraintsWithVisualFormat:@"H:|-[_frontLabel]-|"
                                         options:NSLayoutFormatAlignAllCenterY
                                         metrics:nil
                                         views:NSDictionaryOfVariableBindings(_frontLabel)];
        [self addConstraints:constraint];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

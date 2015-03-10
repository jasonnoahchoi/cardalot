//
//  StudySubjectView.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StudySubjectView.h"

@implementation StudySubjectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //self.information = padding;
        self.backgroundColor = [UIColor colorWithHue:204.0/360 saturation:.78 brightness:.66 alpha:1.0];
        [self.layer setCornerRadius:3];
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.layer.shouldRasterize = YES;

        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"no info given";
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];


        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *leftMarginConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                                attribute:NSLayoutAttributeLeading
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeLeadingMargin
                                                                               multiplier:1.0 constant:3];
        //        //leadingEdgeToMarginConstraint.priority = UILayoutPriorityDefaultHigh;
        [self addConstraint:leftMarginConstraint];

        NSLayoutConstraint *bottomMarginConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:5];
        [self addConstraint:bottomMarginConstraint];

        NSLayoutConstraint *rightMarginConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:-3];
        [self addConstraint:rightMarginConstraint];

        NSLayoutConstraint *topMarginConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:-5];
        [self addConstraint:topMarginConstraint];

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

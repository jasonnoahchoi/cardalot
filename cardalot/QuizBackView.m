//
//  QuizBackView.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/13/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "QuizBackView.h"
#import "UIColor+Colors.h"

@implementation QuizBackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.backTextView = [[UITextView alloc] init];
        self.backTextView.textColor = [UIColor customBlueColor];
        self.backTextView.text = @"Sample back text";
        [self addSubview:self.backTextView];

        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 3.0f;
        self.layer.borderColor = [UIColor customBlueColor].CGColor;
        self.layer.cornerRadius = 3;

        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.backTextView
                                                                   attribute:NSLayoutAttributeLeading
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeLeftMargin
                                                                  multiplier:1.0
                                                                    constant:15];
        [self addConstraint:leading];

        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.backTextView
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeTopMargin
                                                              multiplier:1.0
                                                                constant:15];
        [self addConstraint:top];

        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.backTextView
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeTrailingMargin
                                                              multiplier:1.0
                                                                constant:15];
        [self addConstraint:right];

        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.backTextView
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                                  attribute:NSLayoutAttributeBottomMargin
                                                              multiplier:1.0
                                                                constant:15];
        [self addConstraint:bottom];
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

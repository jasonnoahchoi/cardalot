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
        //self.backTextView = [[UITextView alloc] init];
        self.backTextView = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, self.frame.size.width-30, self.frame.size.height-30)];
        self.backgroundColor = [UIColor whiteColor];
        //[self.backTextView sizeToFit];
        self.backTextView.textColor = [UIColor blackColor];
        self.backTextView.text = @"Sample back text";
        self.backTextView.numberOfLines = 0;
        self.backTextView.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.backTextView];
        self.layer.borderWidth = 3.0f;
        self.layer.borderColor = [UIColor customBlueColor].CGColor;
        self.layer.cornerRadius = 3;

        NSLayoutConstraint *centerXInViewConstraint = [NSLayoutConstraint
                                                            constraintWithItem:self.backTextView
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                            attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                            constant:0];
        [self addConstraint:centerXInViewConstraint];

        NSLayoutConstraint *centerYInViewConstraint = [NSLayoutConstraint
                                                            constraintWithItem:self.backTextView
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                            attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                            constant:0];
        [self addConstraint:centerYInViewConstraint];
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

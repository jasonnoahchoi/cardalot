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
        self.frontLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
       // [self.frontLabel sizeToFit];
        self.frontLabel.textColor = [UIColor whiteColor];
        self.frontLabel.font = [UIFont boldSystemFontOfSize:32];
        self.frontLabel.text = @"Sample text";
        self.frontLabel.numberOfLines = 0;
    
        //self.frontLabel.backgroundColor = [UIColor clearColor];
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
    }
    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        //        self.flipped = YES;
               if (!self.flipped) {
                  [UIView transitionFromView:self toView:self.backView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight
                       completion:nil];
                    self.flipped = NO;
                } else {
                    [UIView transitionFromView:self.backView toView:self duration:1 options:UIViewAnimationOptionCurveEaseOut completion:nil];
                    self.flipped = YES;
                }


        
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  CardCollectionViewCell.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardCollectionViewCell.h"
#import "UIColor+Colors.h"

@interface CardCollectionViewCell ()
{
    CGFloat _shadowWidth;
}

@end

//CGFloat shadowWidth;

@implementation CardCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
  //  [self.textField sizeToFit];
    //[self.textView sizeToFit];

    [self setBackgroundColor:[UIColor backgroundGrayColor]];
    CGRect bounds = self.bounds;
    if (_shadowWidth != bounds.size.width) {
        if (_shadowWidth == 0) {
            [self.layer setMasksToBounds:NO];
            [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
            [self.layer setShadowOpacity:0.5];
            [self.layer setShadowRadius:5.0];
            [self.layer setShadowOffset:CGSizeMake(0 , 0)];
            self.layer.cornerRadius = 5.0;
        }
        [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:bounds] CGPath]];
        _shadowWidth = bounds.size.width;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, self.frame.size.width - 40, 50)];
        self.textField.placeholder = @"text";
        self.textField.backgroundColor = [UIColor customBlueColor];
        self.textField.font = [UIFont boldSystemFontOfSize:18];
        [self.textField.layer setCornerRadius:5];
        self.textField.textColor = [UIColor whiteColor];
        self.textField.textAlignment = NSTextAlignmentCenter;
        [self.textField.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.contentView addSubview:self.textField];
        [self.textField setEnabled:NO];
        //NSLayoutConstraint *topOfTextFieldToTopMargin = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTopMargin multiplier:1 constant:15];

        self.textView = [[UITextView alloc] init];
        //[self.textView layoutIfNeeded];
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 70, self.contentView.frame.size.width - 40, 290)];
        self.textView.text = @"this is a text view";
        self.textView.font = [UIFont systemFontOfSize:17];
        [self.textView.layer setBorderWidth:3.0f];
        [self.textView.layer setBorderColor:[UIColor customBlueColor].CGColor];
        [self.textView.layer setCornerRadius:10];
        //[self.textView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.contentView addSubview:self.textView];
        self.textView.editable = NO;
    }
    
    return self;
}

@end

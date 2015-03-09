//
//  CardCollectionViewCell.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CardCollectionViewCell.h"

@interface CardCollectionViewCell ()
{
    CGFloat _shadowWidth;
}
@end

@implementation CardCollectionViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
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
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, 200, 44)];
        self.textField.placeholder = @"text";
        [self.contentView addSubview:self.textField];
        [self.textField setEnabled:NO];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 80, self.contentView.frame.size.width, 100)];
        self.textView.text = @"this is a text view";
        [self.contentView addSubview:self.textView];
        self.textView.editable = NO;
    }
    
    return self;
}

@end

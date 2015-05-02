//
//  StudyDescriptionView.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StudyDescriptionView.h"

@implementation StudyDescriptionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor colorWithHue:204.0/360 saturation:.78 brightness:.66 alpha:1.0].CGColor;
        self.layer.borderWidth = 5.0f;
        self.layer.cornerRadius = 5;
        self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, self.frame.size.width-30, self.frame.size.height-30)];
        self.descriptionTextView.backgroundColor = [UIColor whiteColor];
        self.descriptionTextView.editable = NO;
        //self.descriptionLabel.text = @"Hello!";
        [self addSubview:self.descriptionTextView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

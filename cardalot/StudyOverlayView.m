//
//  StudyOverlayView.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StudyOverlayView.h"

@implementation StudyOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setMode:(GGOverlayViewMode)mode {
    if (_mode == mode) {
        return;
    }

    _mode = mode;

    if (mode == GGOverlayViewModeLeft) {
        self.imageView.image = [UIImage imageNamed:@"noButton"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"yesButton"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, 100, 100);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

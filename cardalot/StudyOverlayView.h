//
//  StudyOverlayView.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GGOverlayViewModeLeft,
    GGOverlayViewModeRight
} GGOverlayViewMode;

@interface StudyOverlayView : UIView

@property (nonatomic) GGOverlayViewMode mode;
@property (nonatomic, strong) UIImageView *imageView;

@end

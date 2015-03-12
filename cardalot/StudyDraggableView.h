//
//  StudyDraggableView.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudySubjectView.h"
@class StudyOverlayView;

@protocol StudyDraggableViewDelegate <NSObject>

- (void)cardSwipedLeft:(UIView *)card;
- (void)cardSwipedRight:(UIView *)card;

@end

@interface StudyDraggableView : UIView

@property (weak) id <StudyDraggableViewDelegate> delegate;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGPoint originalPoint;
@property (nonatomic, strong) StudyOverlayView *overlayView;
@property (nonatomic, strong) StudySubjectView *subjectView;

@end
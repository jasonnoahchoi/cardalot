//
//  StudyDraggableView.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizFrontView.h"
#import "QuizBackView.h"
@class StudyOverlayView;

@protocol QuizDraggableViewDelegate <NSObject>

- (void)cardSwipedLeft:(UIView *)card;
- (void)cardSwipedRight:(UIView *)card;

@end

@interface QuizDraggableView : UIView

@property (weak) id <QuizDraggableViewDelegate> delegate;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGPoint originalPoint;
@property (nonatomic, strong) StudyOverlayView *overlayView;
@property (nonatomic, strong) QuizFrontView *frontView;
@property (nonatomic, strong) QuizBackView *backView;

@end

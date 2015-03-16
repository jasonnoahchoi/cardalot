//
//  StudyDraggableView.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle


#import "QuizDraggableView.h"
#import "StudyOverlayView.h"
#import "StudyDescriptionView.h"
#import "UIColor+Colors.h"
#import "QuizDraggableViewBackground.h"

#import <QuartzCore/QuartzCore.h>

static CGFloat xFromCenter;
static CGFloat yFromCenter;

@interface QuizDraggableView ()

@property (nonatomic, strong) QuizDraggableViewBackground *background;

@end

@implementation QuizDraggableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];

        self.flipped = NO;

        self.frontView = [[QuizFrontView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        //self.frontView.backgroundColor = [UIColor redColor];
        //self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor customBlueColor];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 4.0f;
        //self.layer.masksToBounds = YES;

        self.backView = [[QuizBackView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        //self.backView.hidden = NO;
       // self.frontView.hidden = NO;
        //self.backView.backgroundColor = [UIColor orangeColor];

        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(beingDragged:)];

        [self addGestureRecognizer:self.panGestureRecognizer];
        [self addSubview:self.backView];
        [self addSubview:self.frontView];
        //[self bringSubviewToFront:self.backView];

        self.overlayView = [[StudyOverlayView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 50, 100, 100, 100)];
        self.overlayView.alpha = 0;
        [self addSubview:self.overlayView];

       // [self.frontView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.backView setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *CenterXFrontView = [NSLayoutConstraint constraintWithItem:self.frontView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:CenterXFrontView];

        NSLayoutConstraint *centerYFrontView = [NSLayoutConstraint constraintWithItem:self.frontView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self addConstraint:centerYFrontView];

        NSLayoutConstraint *CenterXBackView = [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:CenterXBackView];

        NSLayoutConstraint *centerYBackView = [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self addConstraint:centerYBackView];

      //  self.flipped = NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapGesture.numberOfTapsRequired = 2;

        [self addGestureRecognizer:tapGesture];
        

        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {

        [UIView transitionWithView:self.frontView
                          duration:1
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            if (!self.flipped) {
                                self.flipped = YES;
                                 [self.frontView setHidden:NO];
                                //[self.frontView setHidden:YES];
                                //  [self.draggableViewBackground addSubview:self.draggableViewBackground.draggableView.frontView];
                                //  [self.draggableView.backView setHidden:NO];
                                //[self.frontView removeFromSuperview];

                                [self addSubview:self.backView];
                                [self bringSubviewToFront:self.backView];
                                [self sendSubviewToBack:self.frontView];
                                // [self.backView didMoveToSuperview];

                                //  [self.backView setHidden:YES];
                                //  [self.draggableView bringSubviewToFront:self.draggableView.backView];
                                //  [self.draggableViewBackground.draggableView.frontView removeFromSuperview];
                                // [self addSubview:self.draggableView.backView];
                                //  [self.draggableView.backView setAlpha:1];
                                //  [self.draggableViewBackground.draggableView.backView setHidden:NO];
                                //  NSLog(@"%d", self.draggableView.frontView.hidden);

                            } else {
                                self.flipped = NO;
                                //
                                //[self.draggableViewBackground.draggableView.backView setHidden:NO];
                                //   [self.draggableView.frontView setHidden:YES];
                                //  [self.draggableView.frontView removeFromSuperview];

                                // [self.draggableViewBackground bringSubviewToFront:self.draggableViewBackground.draggableView.backView];
                                //[self.draggableView.frontView setAlpha:1];
                                //[self.backView removeFromSuperview];
                                [self addSubview:self.frontView];
                                [self bringSubviewToFront:self.frontView];
                                [self sendSubviewToBack:self.backView];

                                // [self.frontView setHidden:YES];
                                // [self.backView setHidden:NO];

                            }
                        }
                        completion:^(BOOL finished) {

                        }];
    }
}

-(void)setupView {
    self.layer.cornerRadius = 5;
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

//%%% called when you move your finger across the screen.
// called many times a second
- (void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer {
    //%%% this extracts the coordinate data from your swipe movement. (i.e. How much did you move?)
    xFromCenter = [gestureRecognizer translationInView:self].x; //%%% positive for right swipe, negative for left
    yFromCenter = [gestureRecognizer translationInView:self].y; //%%% positive for up, negative for down

    //%%% checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (gestureRecognizer.state) {
            //%%% just started swiping
        case UIGestureRecognizerStateBegan: {
            self.originalPoint = self.center;
            break;
        };
            //%%% in the middle of a swipe
        case UIGestureRecognizerStateChanged: {
            //%%% dictates rotation (see ROTATION_MAX and ROTATION_STRENGTH for details)
            CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);

            //%%% degree change in radians
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);

            //%%% amount the height changes when you move the card up to a certain point
            CGFloat scale = MAX(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);

            //%%% move the object's center by center + gesture coordinate
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);

            //%%% rotate by certain amount
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);

            //%%% scale by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);

            //%%% apply transformations
            self.transform = scaleTransform;
            [self updateOverlay:xFromCenter];

            break;
        };
            //%%% let go of the card
        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

//%%% checks to see if you are moving right or left and applies the correct overlay image
- (void)updateOverlay:(CGFloat)distance {
    if (distance > 0) {
        self.overlayView.mode = GGOverlayViewModeRight;
    } else {
        self.overlayView.mode = GGOverlayViewModeLeft;
    }

    self.overlayView.alpha = MIN(fabsf(distance)/100, 0.4);
}

//%%% called when the card is let go
- (void)afterSwipeAction {
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else { //%%% resets the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             self.overlayView.alpha = 0;
                         }];
    }
}

//%%% called when a swipe exceeds the ACTION_MARGIN to the right
- (void)rightAction {
    CGPoint finishPoint = CGPointMake(500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];

    [self.delegate cardSwipedRight:self];

    NSLog(@"YES");
}

//%%% called when a swip exceeds the ACTION_MARGIN to the left
- (void)leftAction {
    CGPoint finishPoint = CGPointMake(-500, 2 * yFromCenter + self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }
                     completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];

    [self.delegate cardSwipedLeft:self];

    NSLog(@"NO");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

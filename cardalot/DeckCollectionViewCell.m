//
//  DeckCollectionViewCell.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/7/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckCollectionViewCell.h"
#import "DeckCollectionViewLayout.h"
#import "DeckCollectionViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DeckCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.layer setCornerRadius:10];
    self.layer.borderColor = [UIColor colorWithHue:188.0/360 saturation:.83 brightness:.75 alpha:1.0].CGColor;
    //self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 5.0f;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//- (void)startJiggling {
//    CABasicAnimation *quiverAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    float startAngle = (-2) * M_PI/180.0;
//    float stopAngle = -startAngle;
//    quiverAnim.fromValue = [NSNumber numberWithFloat:startAngle];
//    quiverAnim.toValue = [NSNumber numberWithFloat:3 * stopAngle];
//    quiverAnim.autoreverses = YES;
//    quiverAnim.duration = 0.1;
//    quiverAnim.repeatCount = HUGE_VALF;
//    float timeOffset = (float)(arc4random() % 100)/100 - 0.50;
//    quiverAnim.timeOffset = timeOffset;
//    CALayer *layer = self.layer;
//    [layer addAnimation:quiverAnim forKey:@"jiggling"];
//}
//
//
//
//- (void)stopJiggling {
//    CALayer *layer = nil;
//    [layer removeAnimationForKey:@"jiggling"];
//}

@end

//
//  StudyDraggableViewBackground.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyDraggableView.h"

@interface StudyDraggableViewBackground : UIView <StudyDraggableViewDelegate>

@property (retain, nonatomic) NSArray *exampleCardLabels; //%%% the labels the cards
@property (retain, nonatomic) NSMutableArray *allCards; //%%% the labels the cards

//methods called in DraggableView
- (void)cardSwipedLeft:(UIView *)card;
- (void)cardSwipedRight:(UIView *)card;

@end

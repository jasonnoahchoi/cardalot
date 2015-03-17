//
//  QuizFrontView.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/13/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizBackView.h"

@interface QuizFrontView : UIView

@property (nonatomic, strong) UILabel *frontLabel;
@property (nonatomic, strong) QuizBackView *backView;


@end

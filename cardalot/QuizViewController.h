//
//  QuizViewController.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/14/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QuizDraggableViewBackground;
@class Deck;
@class Session;

@interface QuizViewController : UIViewController

@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) Session *session;
@property (nonatomic, strong) QuizDraggableViewBackground *draggableViewBackground;
@property (nonatomic, strong) NSString *type;

@end

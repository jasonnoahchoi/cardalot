//
//  StudyViewController.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Deck;
@class Session;
@class StudyDraggableViewBackground;

@interface StudyViewController : UIViewController

@property (nonatomic, strong) NSString *frontString;
@property (nonatomic, strong) NSString *backString;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) Session *session;
@property (nonatomic, strong) StudyDraggableViewBackground *draggableViewBackground;

@end

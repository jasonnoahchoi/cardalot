//
//  HistoryViewController.h
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Session;
@class Deck;

@interface CompletionViewController : UIViewController

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) Deck *deck;

@end

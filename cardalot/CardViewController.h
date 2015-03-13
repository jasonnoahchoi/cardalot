//
//  CardViewController.h
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeckTagCell.h"
#import "FrontTextCell.h"
#import "BackTextCell.h"
@class Deck;

@interface CardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (strong, nonatomic) Deck *deck;

@end

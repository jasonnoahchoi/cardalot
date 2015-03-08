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


@interface CardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UITableView *cardTableView;

@end

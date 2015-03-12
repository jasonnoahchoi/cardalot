//
//  ViewController.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMDrawerController;

@interface DeckCollectionViewController : UIViewController

@property (nonatomic, strong) MMDrawerController *drawerController;
@property (nonatomic, strong) NSString *deckTitle;

- (void)open;

@end


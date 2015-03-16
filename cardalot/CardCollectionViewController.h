//
//  CardCollectionViewController.h
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Deck;

@interface CardCollectionViewController : UIViewController

@property (nonatomic, strong) Deck *deck;

@end

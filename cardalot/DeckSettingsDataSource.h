//
//  DeckSettingsDataSource.h
//  cardalot
//
//  Created by sombra on 2015-04-11.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

@import UIKit;

@class Deck;

@interface DeckSettingsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Deck *deck;

- (instancetype)initWithDeck:(Deck *)deck;

@end

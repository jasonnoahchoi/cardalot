//
//  DeckController.h
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Deck;
@class Card;

@interface DeckController : NSObject

@property (nonatomic, strong, readonly) NSArray *decks;

+ (DeckController *)sharedInstance;

- (void)save;

- (void)addDeckWithName:(NSString *)nameTag;
- (void)removeDeck:(Deck *)deck;

- (void)addCardToDeckWithNameTag:(NSString *)nameTag;
- (void)removeCard:(Card *)card;

@end

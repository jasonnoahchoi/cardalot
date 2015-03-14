//
//  DeckController.h
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

@class Deck;
@class Card;


@interface DeckController : NSObject

@property (nonatomic, strong, readonly) NSArray *decks;

+ (DeckController *)sharedInstance;

- (void)save;

- (void)addDeckWithName:(NSString *)nameTag;
- (void)removeDeck:(Deck *)deck;

- (void)addCardWithTitle:(NSString *)title andAnswer:(NSString *)answer toDeckWithNameTag:(NSString *)nameTag;
- (void)removeCard:(Card *)card;

- (void)addSessionToDeck:(Deck *)deck withMode:(Mode)mode;
- (void)removeSession:(Session *)session;

@end

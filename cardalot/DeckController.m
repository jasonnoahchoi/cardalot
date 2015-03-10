//
//  DeckController.m
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckController.h"
#import "Deck.h"
#import "Card.h"
#import "Stack.h"

@interface DeckController ()

@property (nonatomic, strong) NSArray *nameTags;

@end

static NSString * const deckEntity = @"Deck";
static NSString * const cardEntity = @"Card";

@implementation DeckController

+ (DeckController *)sharedInstance {
    static DeckController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DeckController alloc] init];
    });
    return sharedInstance;
}

- (NSArray *)decks {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:deckEntity];
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
}

- (NSArray *)nameTags {
    NSMutableArray *mutableNameTags = [[NSMutableArray alloc] init];
    for (Deck *deck in self.decks) {
        NSString *nameTag = deck.nameTag;
        [mutableNameTags addObject:nameTag];
    }
    return mutableNameTags;
}

- (void)save {
    [[Stack sharedInstance].managedObjectContext save:NULL];
}

#pragma Deck stuff
- (void)addDeckWithName:(NSString *)nameTag {
    Deck *deck = [NSEntityDescription insertNewObjectForEntityForName:deckEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    deck.nameTag = nameTag;
    
    [self save];
}

- (void)removeDeck:(Deck *)deck {
    [deck.managedObjectContext deleteObject:deck];
    [self save];
}

#pragma Card stuff
- (void)addCardToDeckWithNameTag:(NSString *)nameTag {
    Card *card = [NSEntityDescription insertNewObjectForEntityForName:cardEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    if (![self.nameTags containsObject:nameTag]) {
        [self addDeckWithName:nameTag];
    }
    
    for (Deck *deck in self.decks) {
        if (deck.nameTag == nameTag) {
            [card setDecks:[NSSet setWithObject:deck]];
            [self save];
        }
    }
}

- (void)removeCard:(Card *)card {
    [card.managedObjectContext deleteObject:card];
    [self save];
}




@end

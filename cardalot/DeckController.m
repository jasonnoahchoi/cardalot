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
#import "PurchasedDataController.h"

@interface DeckController ()

@property (nonatomic, strong) NSArray *nameTags;

@end

static NSString * const deckEntity = @"Deck";
static NSString * const cardEntity = @"Card";
static NSString * const sessionEntity = @"Session";

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
    if ([PurchasedDataController sharedInstance].goPro) {
        return [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    } else {
        // set a limit to 5 decks for FREE version
        [fetchRequest setFetchLimit:5];
        return [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    }
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

#pragma mark Deck stuff
- (void)addDeckWithName:(NSString *)nameTag {
    if ([PurchasedDataController sharedInstance].goPro) {
        Deck *deck = [NSEntityDescription insertNewObjectForEntityForName:deckEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
        deck.nameTag = nameTag;

        [self save];
    } else if (self.decks.count == 5) {
        return;
    }
    Deck *deck = [NSEntityDescription insertNewObjectForEntityForName:deckEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    deck.nameTag = nameTag;

    [self save];
}

- (void)removeDeck:(Deck *)deck {
    [deck.managedObjectContext deleteObject:deck];
    [self save];
}

#pragma mark Card stuff
- (void)addCardWithTitle:(NSString *)title andAnswer:(NSString *)answer toDeckWithNameTag:(NSString *)nameTag {
    if ([PurchasedDataController sharedInstance].goPro == NO && self.decks.count == 5) {
        return;
    } else {
        Deck *deck = [NSEntityDescription insertNewObjectForEntityForName:deckEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
        deck.nameTag = nameTag;

        [self save];
    }
}

- (void)removeCard:(Card *)card {
    [card.managedObjectContext deleteObject:card];
    [self save];
}

#pragma mark Session stuff
- (void)addSessionToDeck:(Deck *)deck withMode:(Mode)mode {
    Session *session = [NSEntityDescription insertNewObjectForEntityForName:sessionEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    [session setDeck:deck];
    session.mode = [NSNumber numberWithInt:mode];
    [self save];
}

- (void)removeSession:(Session *)session {
    [session.managedObjectContext deleteObject:session];
    [self save];
}

- (void)configureWithPurchases {
    if ([PurchasedDataController sharedInstance].goPro) {
        NSLog(@"Go Pro!");
        
    }
}

- (void)purchasesUpdated:(NSNotification *)notification {
    [self configureWithPurchases];
}

- (void)registerForPurchaseNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchasesUpdated:) name:kPurchasedContentUpdated object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPurchasedContentUpdated object:nil];
}


@end

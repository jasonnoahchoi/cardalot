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
#import "Quiz.h"
#import "Study.h"
#import "Stack.h"

@interface DeckController ()

@property (nonatomic, strong) NSArray *nameTags;

@end

static NSString * const deckEntity = @"Deck";
static NSString * const cardEntity = @"Card";
static NSString * const quizEntity = @"Quiz";
static NSString * const studyEntity = @"Study";

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

#pragma mark Deck stuff
- (void)addDeckWithName:(NSString *)nameTag {
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
    Card *card = [NSEntityDescription insertNewObjectForEntityForName:cardEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    card.title = title;
    card.answer = answer;
    
    if (![self.nameTags containsObject:nameTag]) {
        [self addDeckWithName:nameTag];
    }
    
    for (Deck *deck in self.decks) {
        if ([deck.nameTag isEqualToString:nameTag]) {
            [card setDecks:[NSSet setWithObject:deck]];
            [self save];
        }
    }
}

- (void)removeCard:(Card *)card {
    [card.managedObjectContext deleteObject:card];
    [self save];
}

#pragma mark Quiz stuff
- (void)addQuizToDeck:(Deck *)deck {
    Quiz *quiz = [NSEntityDescription insertNewObjectForEntityForName:quizEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    [quiz setDeck:deck];
    [self save];
}

#pragma mark Study stuff
- (void)addStudyToDeck:(Deck *)deck {
    Study *study = [NSEntityDescription insertNewObjectForEntityForName:studyEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    [study setDeck:deck];
    [self save];
}

@end

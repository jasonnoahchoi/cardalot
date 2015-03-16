//
//  Card.h
//  cardalot
//
//  Created by sombra on 2015-03-13.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Deck, Stat;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSSet *decks;
@property (nonatomic, retain) NSOrderedSet *stats;
@end

@interface Card (CoreDataGeneratedAccessors)

- (void)addDecksObject:(Deck *)value;
- (void)removeDecksObject:(Deck *)value;
- (void)addDecks:(NSSet *)values;
- (void)removeDecks:(NSSet *)values;

- (void)insertObject:(Stat *)value inStatsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromStatsAtIndex:(NSUInteger)idx;
- (void)insertStats:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeStatsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInStatsAtIndex:(NSUInteger)idx withObject:(Stat *)value;
- (void)replaceStatsAtIndexes:(NSIndexSet *)indexes withStats:(NSArray *)values;
- (void)addStatsObject:(Stat *)value;
- (void)removeStatsObject:(Stat *)value;
- (void)addStats:(NSOrderedSet *)values;
- (void)removeStats:(NSOrderedSet *)values;
@end

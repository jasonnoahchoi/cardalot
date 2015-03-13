//
//  Deck.h
//  cardalot
//
//  Created by sombra on 2015-03-13.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Deck : NSManagedObject

@property (nonatomic, retain) NSString *nameTag;
@property (nonatomic, retain) NSOrderedSet *cards;
@property (nonatomic, retain) NSOrderedSet *sessions;
@end

@interface Deck (CoreDataGeneratedAccessors)

- (void)insertObject:(Card *)value inCardsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCardsAtIndex:(NSUInteger)idx;
- (void)insertCards:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCardsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCardsAtIndex:(NSUInteger)idx withObject:(Card *)value;
- (void)replaceCardsAtIndexes:(NSIndexSet *)indexes withCards:(NSArray *)values;
- (void)addCardsObject:(Card *)value;
- (void)removeCardsObject:(Card *)value;
- (void)addCards:(NSOrderedSet *)values;
- (void)removeCards:(NSOrderedSet *)values;
- (void)insertObject:(NSManagedObject *)value inSessionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSessionsAtIndex:(NSUInteger)idx;
- (void)insertSessions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSessionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSessionsAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceSessionsAtIndexes:(NSIndexSet *)indexes withSessions:(NSArray *)values;
- (void)addSessionsObject:(NSManagedObject *)value;
- (void)removeSessionsObject:(NSManagedObject *)value;
- (void)addSessions:(NSOrderedSet *)values;
- (void)removeSessions:(NSOrderedSet *)values;
@end

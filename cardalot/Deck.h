//
//  Deck.h
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Deck : NSManagedObject

@property (nonatomic, retain) NSString * nameTag;
@property (nonatomic, retain) NSOrderedSet *cards;
@end

@interface Deck (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inCardsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCardsAtIndex:(NSUInteger)idx;
- (void)insertCards:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCardsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCardsAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceCardsAtIndexes:(NSIndexSet *)indexes withCards:(NSArray *)values;
- (void)addCardsObject:(NSManagedObject *)value;
- (void)removeCardsObject:(NSManagedObject *)value;
- (void)addCards:(NSOrderedSet *)values;
- (void)removeCards:(NSOrderedSet *)values;
@end

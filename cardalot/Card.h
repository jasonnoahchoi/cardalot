//
//  Card.h
//  cardalot
//
//  Created by sombra on 2015-03-06.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Deck;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSSet *decks;
@end

@interface Card (CoreDataGeneratedAccessors)

- (void)addDecksObject:(Deck *)value;
- (void)removeDecksObject:(Deck *)value;
- (void)addDecks:(NSSet *)values;
- (void)removeDecks:(NSSet *)values;

@end

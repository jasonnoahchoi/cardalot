//
//  Session.h
//  cardalot
//
//  Created by sombra on 2015-03-13.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Deck, Stat;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSNumber * markedCorrect;
@property (nonatomic, retain) NSNumber * mode;
@property (nonatomic, retain) Deck *deck;
@property (nonatomic, retain) NSSet *stats;
@end

@interface Session (CoreDataGeneratedAccessors)

- (void)addStatsObject:(Stat *)value;
- (void)removeStatsObject:(Stat *)value;
- (void)addStats:(NSSet *)values;
- (void)removeStats:(NSSet *)values;

@end

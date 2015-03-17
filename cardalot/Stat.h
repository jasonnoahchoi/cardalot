//
//  Stat.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/14/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card, Session;

@interface Stat : NSManagedObject

@property (nonatomic, retain) NSNumber * markedCorrect;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) Session *session;

@end

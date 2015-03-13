//
//  Stat.h
//  cardalot
//
//  Created by sombra on 2015-03-13.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Stat : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * markedCorrect;
@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) NSManagedObject *session;

@end

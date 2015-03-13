//
//  Study.h
//  cardalot
//
//  Created by sombra on 2015-03-12.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Deck;

@interface Study : NSManagedObject

@property (nonatomic, retain) NSNumber * left;
@property (nonatomic, retain) NSNumber * right;
@property (nonatomic, retain) Deck *deck;

@end

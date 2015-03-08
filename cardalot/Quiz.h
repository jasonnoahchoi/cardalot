//
//  Quiz.h
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Quiz : NSManagedObject

@property (nonatomic, retain) NSNumber * left;
@property (nonatomic, retain) NSNumber * right;

@end

//
//  QuizController.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "QuizController.h"
#import "Stack.h"
#import "Quiz.h"

static NSString * const quizEntity = @"Quiz";

@implementation QuizController

+ (QuizController *)sharedInstance {
    static QuizController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[QuizController alloc] init];
    });
    return sharedInstance;
}

- (void)save {
    [[Stack sharedInstance].managedObjectContext save:NULL];
}

- (NSArray *)quizzes {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:quizEntity];
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
}

- (void)addQuiz {
    [NSEntityDescription insertNewObjectForEntityForName:quizEntity inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    [self save];
}

@end

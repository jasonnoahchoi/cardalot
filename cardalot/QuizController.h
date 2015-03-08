//
//  QuizController.h
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Quiz;

@interface QuizController : NSObject

@property (nonatomic, strong, readonly) NSArray *quizzes;

+ (QuizController *)sharedInstance;

- (void)save;

- (void)addQuiz;

@end

//
//  ImageController.h
//  PagingImages
//
//  Created by Jason Noah Choi on 2/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageController : NSObject

+ (ImageController *)sharedInstance;

@property (nonatomic, strong, readonly) NSArray *images;

@end

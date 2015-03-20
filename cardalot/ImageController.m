//
//  ImageController.m
//  PagingImages
//
//  Created by Jason Noah Choi on 2/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "ImageController.h"
#import "ImageDataSource.h"

@interface ImageController ()

@property (nonatomic, strong) NSArray *images;

@end


@implementation ImageController

+ (ImageController *)sharedInstance {
    static ImageController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImageController alloc] init];

        sharedInstance.images = @[[UIImage imageNamed:@"Login.png"], [UIImage imageNamed:@"Login1.png"], [UIImage imageNamed:@"Login2"]];
    });
    return sharedInstance;
}



@end

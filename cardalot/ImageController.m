//
//  ImageController.m
//  PagingImages
//
//  Created by Jason Noah Choi on 2/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "ImageController.h"
#import "TutorialSlidesPageViewControllerDataSource.h"

@interface ImageController ()

@property (nonatomic, strong) NSArray *images;

@end


@implementation ImageController

+ (ImageController *)sharedInstance {
    static ImageController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImageController alloc] init];

        sharedInstance.images = @[[UIImage imageNamed:@"Screenshot1"], [UIImage imageNamed:@"Screenshot2"], [UIImage imageNamed:@"Screenshot3"], [UIImage imageNamed:@"Screenshot4"], [UIImage imageNamed:@"Screenshot5"]];
    });
    return sharedInstance;
}



@end

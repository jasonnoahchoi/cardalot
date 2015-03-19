//
//  PurchasedDataController.h
//  SimpleStore
//
//  Created by Caleb Hicks on 3/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kPurchasedContentUpdated = @"kPurchasedContentUpdated";

@interface PurchasedDataController : NSObject

@property (assign, nonatomic, readonly) BOOL goPro;

+ (PurchasedDataController *)sharedInstance;

@end

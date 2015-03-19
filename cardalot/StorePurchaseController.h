//
//  StorePurchaseController.h
//  cardalot
//
//  Created by Jason Choi
//  Copyright (c) 2015 Weekend Concept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

static NSString * const kInAppPurchaseFetchedNotification = @"kInAppPurchaseFetchedNotification";
static NSString * const kInAppPurchaseCompletedNotification = @"kInAppPurchaseCompletedNotification";
static NSString * const kInAppPurchaseRestoredNotification = @"kInAppPurchaseRestoredNotification";

static NSString * const kProductIDKey = @"productID";

@interface StorePurchaseController : NSObject

@property (nonatomic, strong) NSArray *products;

+ (StorePurchaseController *)sharedInstance;

- (void)requestProducts;
- (void)restorePurchases;
- (void)purchaseOptionSelectedObjectIndex:(NSUInteger)index;

- (NSSet *)bundledProducts;

@end

//
//  PurchasedDataController.m
//  SimpleStore
//
//  Created by Caleb Hicks on 3/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "PurchasedDataController.h"
#import "StorePurchaseController.h"

static NSString * const kGoPro = @"goPro";

@interface PurchasedDataController ()

@property (assign, nonatomic) BOOL goPro;

@end

@implementation PurchasedDataController

+ (PurchasedDataController *)sharedInstance {
    static PurchasedDataController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PurchasedDataController new];
        [sharedInstance registerForNotifications];
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseNotification:) name:kInAppPurchaseCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseNotification:) name:kInAppPurchaseRestoredNotification object:nil];
}

#pragma mark - Properties to/from NSUserDefaults

- (void)loadFromDefaults {
        
    self.goPro = [[NSUserDefaults standardUserDefaults] integerForKey:kGoPro];
//    self.goldStar = [[NSUserDefaults standardUserDefaults] boolForKey:kGoldStarKey];
//    self.adsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:kAdsRemovedKey];
//
//    if (!self.gold) {
//        self.gold = 0;
//    }

    if (!self.goPro) {
        self.goPro = NO;
    }
}

- (void)setGoPro:(BOOL)goPro {
    _goPro = goPro;

    [[NSUserDefaults standardUserDefaults] setBool:goPro forKey:kGoPro];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//- (void)setGold:(NSInteger)gold {
//    _gold = gold;
//    
//    [[NSUserDefaults standardUserDefaults] setInteger:gold forKey:kGoldKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (void)setGoldStar:(BOOL)goldStar {
//    _goldStar = goldStar;
//    
//    [[NSUserDefaults standardUserDefaults] setBool:goldStar forKey:kGoldStarKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (void)setAdsRemoved:(BOOL)adsRemoved {
//    _adsRemoved = adsRemoved;
//    
//    [[NSUserDefaults standardUserDefaults] setBool:adsRemoved forKey:kAdsRemovedKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

#pragma mark - Handle Purchase Notification

- (void)purchaseNotification:(NSNotification *)notification {
    
    NSString *productIdentifer = notification.userInfo[kProductIDKey];
    
    if ([productIdentifer isEqualToString:@"com.cardalot.cardalot.goPro"]) {
        self.goPro = YES;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:kPurchasedContentUpdated object:nil userInfo:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

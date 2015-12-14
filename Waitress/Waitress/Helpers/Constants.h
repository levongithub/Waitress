//
//  Constants.h
//  Crowdspan
//
//  Created by Arman Manukyan on 6/4/14.
//  Copyright (c) 2014 Arman Manukyan. All rights reserved.
//

#ifndef Crowdspan_Constants_h
#define Crowdspan_Constants_h

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define HEIGHT_IPHONE_5 568
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds ].size.height == HEIGHT_IPHONE_5 )
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#pragma mark - notifications

static NSString *const kRLItemScannedNotification        = @"model.kRLItemScannedNotification";
static NSString *const kRLMultiscanDoneSucessedNotificaiton        = @"model.kRLMultiscanDoneSucessedNotificaiton";
static NSString *const kRLScrollviewWillScroll        = @"kRLScrollviewWillScroll";
static NSString *const kRLScrollviewDidEndScroll        = @"kRLScrollviewwillScroll";


static NSString *const kRLSingleScanSucessedNotificaiton        = @"model.kRLSingleScanSucessedNotificaiton";

static NSString *const kMegicButtonTypeChangeNotification = @"kMegicButtonTypeChangeNotification";

static NSString *const kTabBarViewHideNotification = @"kTabBarViewHideNotificationGRDON";
static NSString *const kTabBarViewHideKeyboardNotification = @"kTabBarViewHideKeyboardNotificationGRDON";
static NSString *const kUserDidSignInNotification = @"kUserDidSignInNotification";
static NSString *const kShowSignInViewNotification = @"kShowSignInViewNotification";

typedef enum {
    
    POST = 0,
    OFFER,
    
}MEGIC_BUTTON_TYPE;

typedef enum {
    
    Buy = 0,
    Sell = 1

}OFFER_TYPE;

typedef enum {

    New = 0,
    Usd = 1

}POST_TYPE;

#endif

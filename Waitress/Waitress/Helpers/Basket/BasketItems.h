//
//  BasketItems.h
//  Waitress
//
//  Created by Arman Manukyan on 12/23/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAProduct.h"
#import "WAProductOrder.h"

@interface BasketItems : NSObject

@property (nonatomic, strong) NSMutableArray * basketItems;

+ (instancetype)sharedInstance;

- (void) addScannedItemsObject:(WAProductOrder *)object;
- (BOOL) isProductExistInBasket:(WAProduct *)object;
- (void) changeCount:(NSNumber *)count;
- (void) clearItems;

@end

//
//  BasketItems.m
//  Waitress
//
//  Created by Arman Manukyan on 12/23/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "BasketItems.h"

@interface BasketItems () {
    
    WAProductOrder *currentWAProductOrder;
}

@end

@implementation BasketItems

+ (instancetype)sharedInstance {

    static BasketItems *basketItems = nil;
    
    if (!basketItems) {
        
        basketItems = [[BasketItems alloc] init];
    }
    
    return basketItems;
}
- (instancetype) init {
    
    self = [super init];
    
    if (self) {
        
        _basketItems = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void) addScannedItemsObject:(WAProductOrder *)object {
    
    [_basketItems addObject:object];
}
- (BOOL) isProductExistInBasket:(WAProduct *)object {
    
    for (WAProductOrder *waProductOrder in _basketItems) {
        
        WAProduct *product = [waProductOrder product];
        
        if ([product isEqual:object]) {
            
            currentWAProductOrder = waProductOrder;
            return YES;
        }
    }
    return NO;
}
- (void) changeCount:(NSNumber *)count {
    
    NSInteger priceProduct = ([[[currentWAProductOrder product] price]integerValue] * [count integerValue]);

    [currentWAProductOrder incrementKey:@"orderCount" byAmount:count];
    [currentWAProductOrder incrementKey:@"price" byAmount:@(priceProduct)];
}
- (void) clearItems {
}
@end
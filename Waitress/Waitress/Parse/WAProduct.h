//
//  WAProduct.h
//  Waitress
//
//  Created by Arman Manukyan on 12/15/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <Parse/Parse.h>
#import "WARestaurant.h"
@interface WAProduct : PFObject<PFSubclassing>

- (NSString *)name;
- (void) setName:(NSString *)name;

- (PFFile *)avatar;
- (void)setAvatar:(PFFile *)avatar;

- (NSNumber *)price;
- (void) setPrice:(NSNumber *)price;

- (NSString *)currencySymbol;
- (void) setCurrencySymbol:(NSString *)currencySymbol;

- (NSNumber *)index;
- (void) setIndex:(NSNumber *)index;

- (WARestaurant *)restaurant;
- (void) setRestaurant:(WARestaurant *)restaurant;

@end
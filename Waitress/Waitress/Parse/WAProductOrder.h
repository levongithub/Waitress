//
//  WAProductOrder.h
//  Waitress
//
//  Created by Arman Manukyan on 12/23/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <Parse/Parse.h>
#import "WAProduct.h"

@interface WAProductOrder : PFObject<PFSubclassing>

- (WAProduct *)product;
- (void)setProduct:(WAProduct *)product;

- (NSNumber *)price;
- (void)setPrice:(NSNumber *)price;

- (NSNumber *)orderCount;
- (void)setOrderCount:(NSNumber *)orderCount;

@end
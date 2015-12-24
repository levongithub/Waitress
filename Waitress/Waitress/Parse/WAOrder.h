//
//  WAOrder.h
//  Waitress
//
//  Created by Arman Manukyan on 12/23/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <Parse/Parse.h>
#import "WARestaurant.h"

@interface WAOrder : PFObject <PFSubclassing>

- (WARestaurant *)restaurant;
- (void)setRestaurant:(WARestaurant *)restaurant;

- (NSNumber *)price;
- (void)setPrice:(NSNumber *)price;

- (NSNumber *)tableNO;
- (void)setTableNO:(NSNumber *)tableNO;

- (PFRelation *)products;

@end
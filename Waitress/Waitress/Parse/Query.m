//
//  Query.m
//  Waitress
//
//  Created by Arman Manukyan on 12/13/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "Query.h"
#import "WARestaurant.h"

@implementation Query

+(void) getRestaurantskip:(long)skip limit:(long)limit withSuccess:(void(^)(NSArray *items, NSError *error))success {
    
    PFQuery *query = [WARestaurant query];
    [query setLimit:limit];
    [query setSkip:skip];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        success(objects, error);
    }];
}

@end

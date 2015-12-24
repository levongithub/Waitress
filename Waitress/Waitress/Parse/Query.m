//
//  Query.m
//  Waitress
//
//  Created by Arman Manukyan on 12/13/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "Query.h"

@implementation Query

+(void) getRestaurantskip:(long)skip limit:(long)limit withSuccess:(void(^)(NSArray *items, NSError *error))success {
    
    PFQuery *query = [WARestaurant query];
    [query setLimit:limit];
    [query setSkip:skip];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        success(objects, error);
    }];
}
+(void) getCategoryForRestaurant:(WARestaurant *)waRestaurant  skip:(long)skip limit:(long)limit withSuccess:(void(^)(NSArray *items, NSError *error))success {
    
    PFRelation *relationCategory = [waRestaurant categories];
    PFQuery *query = [relationCategory query];
    [query setSkip:skip];
    [query setLimit:limit];
    [query orderByAscending:@"index"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
        success(objects, error);
        
    }];
}
+(void) getProductForCategory:(WACategory *)waCategory skip:(long)skip limit:(long)limit withSuccess:(void(^)(NSArray *items, NSError *error))success {
    
    PFRelation *relationProduct = [waCategory products];
    PFQuery *query = [relationProduct query];
    [query setSkip:skip];
    [query setLimit:limit];
    [query orderByAscending:@"index"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        success(objects, error);
        
    }];
}
@end

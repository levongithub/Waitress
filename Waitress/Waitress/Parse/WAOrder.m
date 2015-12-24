//
//  WAOrder.m
//  Waitress
//
//  Created by Arman Manukyan on 12/23/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "WAOrder.h"

@implementation WAOrder

+ (void)load {
    
    [self registerSubclass];
}

#pragma mark - Parse properties
+ (NSString *)parseClassName {
    
    return @"Order";
}
- (WARestaurant *)restaurant {
    
    return [self objectForKey:@"restaurant"];
}
- (void) setRestaurant:(WARestaurant *)restaurant {
    
    [self setObject:restaurant forKey:@"restaurant"];
}
- (NSNumber *)price {
    
    return [self objectForKey:@"price"];
}
- (void)setPrice:(NSNumber *)price {
    
    [self setObject:price forKey:@"price"];
}
- (NSNumber *)tableNO {
    
    return [self objectForKey:@"tableNO"];
}
- (void)setTableNO:(NSNumber *)tableNO {
    
    [self setObject:tableNO forKey:@"tableNO"];
}
- (PFRelation *)products {
    
    return [self relationForKey:@"products"];
}
@end
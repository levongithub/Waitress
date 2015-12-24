//
//  WAProductOrder.m
//  Waitress
//
//  Created by Arman Manukyan on 12/23/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "WAProductOrder.h"

@implementation WAProductOrder

+ (void)load {
    
    [self registerSubclass];
}

#pragma mark - Parse properties
+ (NSString *)parseClassName {
    
    return @"ProductOrder";
}
- (WAProduct *)product {
    
    return [self objectForKey:@"product"];
}
- (void)setProduct:(WAProduct *)product {
    
    [self setObject:product forKey:@"product"];
}

- (NSNumber *)price {
    
    return [self objectForKey:@"price"];
}
- (void)setPrice:(NSNumber *)price {
    
    [self setObject:price forKey:@"price"];
}
- (NSNumber *)orderCount {
    
    return [self objectForKey:@"orderCount"];
}
- (void)setOrderCount:(NSNumber *)orderCount {
    
    [self setObject:orderCount forKey:@"orderCount"];
}
- (BOOL) isEqual:(id)object {
    
    if ([[self objectId] isEqualToString:[(WAProductOrder *)(object) objectId]]) {
        
        return YES;
    }
    return NO;
}
@end
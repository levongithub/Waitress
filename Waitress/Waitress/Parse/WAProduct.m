//
//  WAProduct.m
//  Waitress
//
//  Created by Arman Manukyan on 12/15/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "WAProduct.h"

@implementation WAProduct

+ (void)load {
    
    [self registerSubclass];
}

#pragma mark - Parse properties
+ (NSString *)parseClassName {
    
    return @"Product";
}
- (NSString *)name {
    
    return [self objectForKey:@"name"];
}
- (void) setName:(NSString *)name {
    
    [self setObject:name forKey:@"name"];
}
- (PFFile *)avatar {
    
    return [self objectForKey:@"avatar"];
    
}
- (void)setAvatar:(PFFile *)avatar {
    
    [self setObject:avatar forKey:@"avatar"];
    
}
- (NSNumber *)price {
    
    return [self objectForKey:@"price"];
}
- (void) setPrice:(NSNumber *)price {
    
    [self setObject:price forKey:@"price"];
    
}
- (NSString *)currencySymbol {
    
    return [self objectForKey:@"currencySymbol"];
}
- (void) setCurrencySymbol:(NSString *)currencySymbol {
    
    [self setObject:currencySymbol forKey:@"currencySymbol"];
}
- (NSNumber *)index {
    
    return [self objectForKey:@"index"];
}
- (void) setIndex:(NSNumber *)index {
    
    [self setObject:index forKey:@"index"];
}
- (WARestaurant *)restaurant {
    
    return [self objectForKey:@"restaurant"];
}
- (void) setRestaurant:(WARestaurant *)restaurant {
    
    [self setObject:restaurant forKey:@"restaurant"];
}
- (BOOL) isEqual:(id)object {
    
    if ([[self objectId] isEqualToString:[(WAProduct *)(object) objectId]]) {
        
        return YES;
    }
    
    return NO;
}
@end
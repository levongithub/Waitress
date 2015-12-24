//
//  WACategory.m
//  Waitress
//
//  Created by Arman Manukyan on 12/14/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "WACategory.h"

@implementation WACategory

+ (void)load {
    
    [self registerSubclass];
}

#pragma mark - Parse properties
+ (NSString *)parseClassName {
    
    return @"Category";
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
- (void) setAvatar:(PFFile *)avatar {
    
    [self setObject:avatar forKey:@"avatar"];
}
- (NSNumber *)index {
    
    return [self objectForKey:@"index"];
}
- (void) setIndex:(NSNumber *)index {
    
    [self setObject:index forKey:@"index"];
}

- (PFRelation *)products {
    
    return [self relationForKey:@"products"];
}

@end
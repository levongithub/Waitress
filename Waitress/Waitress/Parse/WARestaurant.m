//
//  WARestaurant.m
//  Waitress
//
//  Created by Arman Manukyan on 12/14/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "WARestaurant.h"

@implementation WARestaurant

+ (void)load {
    
    [self registerSubclass];
}

#pragma mark - Parse properties
+ (NSString *)parseClassName {
    
    return @"Restaurant";
}

- (NSString *) name {
    
    return [self objectForKey:@"name"];
}

- (void) setName:(NSString *) name {
    
    [self setObject:name forKey:@"name"];
}

- (PFFile *) avatar {
    
    return [self objectForKey:@"avatar"];
}
- (NSNumber *) starCount {
    
    return [self objectForKey:@"starCount"];
}

- (void) starCount:(NSNumber *)starCount {
    
    [self setObject:starCount forKey:@"starCount"];
}

- (void) setAvatar:(PFFile *)avatar {
    
    [self setObject:avatar forKey:@"avatar"];
}

- (PFRelation *) categories {
    
    return [self relationForKey:@"categories"];
}

@end

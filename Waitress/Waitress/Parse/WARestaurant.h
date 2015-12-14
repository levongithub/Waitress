//
//  WARestaurant.h
//  Waitress
//
//  Created by Arman Manukyan on 12/14/15.
//  Copyright © 2015 Waitress. All rights reserved.
//
@interface WARestaurant : PFObject<PFSubclassing>

- (NSString *) name;
- (void) setName:(NSString *) name;

- (PFFile *) avatar;
- (void) setAvatar:(PFFile *)avatar;

- (NSNumber *) starCount;
- (void) starCount:(NSNumber *)starCount;

- (PFRelation *) categories;

@end

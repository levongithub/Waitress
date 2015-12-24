//
//  WACategory.h
//  Waitress
//
//  Created by Arman Manukyan on 12/14/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WACategory : PFObject<PFSubclassing>

- (NSString *)name;
- (void) setName:(NSString *)name;

- (PFFile *)avatar;
- (void) setAvatar:(PFFile *)avatar;

- (NSNumber *)index;
- (void) setIndex:(NSNumber *)index;

- (PFRelation *)products;

@end

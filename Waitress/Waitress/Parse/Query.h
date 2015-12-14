//
//  Query.h
//  Waitress
//
//  Created by Arman Manukyan on 12/13/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Query : NSObject

+(void) getRestaurantskip:(long)skip limit:(long)limit withSuccess:(void(^)(NSArray *items, NSError *error))success;

@end

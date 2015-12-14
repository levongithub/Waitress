//
//  RestaurantTableViewCell.h
//  Waitress
//
//  Created by Arman Manukyan on 12/14/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WARestaurant.h"

@protocol RestaurantTableViewCellDelegate

@end

@interface RestaurantTableViewCell : UITableViewCell

@property (weak, nonatomic) id <RestaurantTableViewCellDelegate> delegate;

@property (nonatomic, strong) WARestaurant *waRestaurant;


@end

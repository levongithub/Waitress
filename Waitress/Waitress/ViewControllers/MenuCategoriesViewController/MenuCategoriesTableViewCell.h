//
//  MenuCategoriesTableViewCell.h
//  Waitress
//
//  Created by Arman Manukyan on 12/14/15.
//  Copyright © 2015 Waitress. All rights reserved.
//
#import "WACategory.h"

@protocol MenuCategoriesTableViewCellDelegate

@end

#import <UIKit/UIKit.h>

@interface MenuCategoriesTableViewCell : UITableViewCell

@property (weak, nonatomic) id <MenuCategoriesTableViewCellDelegate> delegate;
@property (strong, nonatomic) WACategory *waCategory;

@end

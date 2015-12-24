//
//  ProductTableViewCell.h
//  Waitress
//
//  Created by Arman Manukyan on 12/15/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAProduct.h"

@protocol ProductTableViewCellDelegate

- (void)setCellInfoForKey:(NSString *)key object:(NSDictionary *)object;

@end

@interface ProductTableViewCell : UITableViewCell

@property (strong, nonatomic) id <ProductTableViewCellDelegate> delegate;
@property (strong, nonatomic) WAProduct *waProduct;

- (void) fillCellInfo:(NSDictionary *)dictionary;

@end
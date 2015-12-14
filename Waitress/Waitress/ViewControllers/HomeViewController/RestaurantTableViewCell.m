//
//  RestaurantTableViewCell.m
//  Waitress
//
//  Created by Arman Manukyan on 12/14/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "RestaurantTableViewCell.h"

@interface RestaurantTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@end

@implementation RestaurantTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = _avatar.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setWaRestaurant:(WARestaurant *)waRestaurant {
    
    _waRestaurant = waRestaurant;
    [self fillView];
}

- (void) fillView {
    
    [_avatar sd_setImageWithURL:[NSURL URLWithString:[[_waRestaurant avatar]url]]
               placeholderImage:[UIImage imageNamed:@"restaurantPlaceholder.png"]
                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          
                          [_avatar setImage:image];
    }];
    
    [_name setText:[_waRestaurant name]];
}

@end

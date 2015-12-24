//
//  ProductTableViewCell.m
//  Waitress
//
//  Created by Arman Manukyan on 12/15/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "BasketItems.h"

@interface ProductTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *commonPrice;
@property (weak, nonatomic) IBOutlet UILabel *orederCount;

@end

@implementation ProductTableViewCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setWaProduct:(WAProduct *)waProduct {
    
    _waProduct = waProduct;
    [self fillView];
}
- (void) fillView {
  
    [_avatar sd_setImageWithURL:[NSURL URLWithString:[[_waProduct avatar]url]]
               placeholderImage:[UIImage imageNamed:@"restaurantPlaceholder.png"]
                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          
                          [_avatar setImage:image];
      }];
    
    [_name setText:[_waProduct name]];
    
    [_orederCount setText:@"1"];
    [_commonPrice setText:[NSString stringWithFormat:@"%i %@",[[_waProduct price]intValue], [_waProduct currencySymbol]]];
}
- (void) fillCellInfo:(NSDictionary *)dictionary {
    
    [self changeCountAndCommonPriceForCount:[[dictionary objectForKey:@"count"] intValue]];
}
- (IBAction)btnAddRemoveToCart {
    
    
    NSInteger count = [_orederCount.text integerValue];
    NSInteger commonPrice = [_commonPrice.text integerValue];
    
    if ([[BasketItems sharedInstance] isProductExistInBasket:_waProduct]) {
        
        [[BasketItems sharedInstance] changeCount:@(count)];
        
    } else {
     
        WAProductOrder *waProductOrder = [[WAProductOrder alloc] init];
        
        [waProductOrder setProduct:_waProduct];
        [waProductOrder setOrderCount:@(count)];
        [waProductOrder setPrice:@(commonPrice)];
        [[BasketItems sharedInstance] addScannedItemsObject:waProductOrder];
    }
}
- (IBAction)btnMiusClick {
    
    int count = [_orederCount.text intValue];
    if (count != 1) {
        
        count --;
        [self changeCountAndCommonPriceForCount:count];
    }
}
- (IBAction)btnPluseClick {
    
    int count = [_orederCount.text intValue];
    count ++;
    [self changeCountAndCommonPriceForCount:count];
}
- (void)changeCountAndCommonPriceForCount:(int) count {
    
    [_orederCount setText:[NSString stringWithFormat:@"%i", count]];
    [_commonPrice setText:[NSString stringWithFormat:@"%i %@",[[_waProduct price]intValue]* count, [_waProduct currencySymbol]]];
    
    NSNumber *number = [[NSNumber alloc] initWithInt:count];
    
    [_delegate setCellInfoForKey:[_waProduct objectId] object:@{@"count":number}];
}
@end
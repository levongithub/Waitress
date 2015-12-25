//
//  ProductViewController.m
//  Waitress
//
//  Created by Arman Manukyan on 12/15/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductTableViewCell.h"
#import "Query.h"

@interface ProductViewController () <UITableViewDelegate, UITableViewDataSource, ProductTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *productTabelView;

@property (nonatomic, strong) NSMutableDictionary *cellInfo;
@property (strong, nonatomic) NSArray *arrayWAProduct;


@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _productTabelView.delegate = self;
    _productTabelView.dataSource = self;
    
    [_productTabelView registerClass:[ProductTableViewCell class] forCellReuseIdentifier:@"ProductTableViewCell"];
    UINib *cellNibProductTableViewCell = [UINib nibWithNibName:@"ProductTableViewCell" bundle:nil];
    [_productTabelView registerNib:cellNibProductTableViewCell forCellReuseIdentifier:@"ProductTableViewCell"];
    
    _cellInfo = [[NSMutableDictionary alloc] init];
    
    [self getProducts];
}
- (void) getProducts {
    
    [Query getProductForCategory:_waCategory skip:skipCount limit:limitCount withSuccess:^(NSArray *items, NSError *error) {
        
        _arrayWAProduct = items;
        [_productTabelView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setWaCategory:(WACategory *)waCategory {
    
    _waCategory = waCategory;
}
#pragma mark Tabel delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [_arrayWAProduct count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductTableViewCell";
    
    ProductTableViewCell *cell = (ProductTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        cell = [[ProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.delegate = self;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setWaProduct:_arrayWAProduct[indexPath.row]];
    
    if ([_cellInfo objectForKey:[_arrayWAProduct[indexPath.row] objectId]]) {
        
        [cell fillCellInfo:[_cellInfo objectForKey:[_arrayWAProduct[indexPath.row] objectId]]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark ProductTableViewCellDelegate
- (void)setCellInfoForKey:(NSString *)key object:(NSDictionary *)object {
    
    [_cellInfo setObject:object forKey:key];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

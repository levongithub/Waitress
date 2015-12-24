//
//  MenuCategoriesViewController.m
//  Waitress
//
//  Created by Arman Manukyan on 12/14/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "MenuCategoriesViewController.h"
#import "WACategory.h"
#import "MenuCategoriesTableViewCell.h"
#import "Query.h"
#import "ProductViewController.h"

@interface MenuCategoriesViewController ()<UITableViewDelegate, UITableViewDataSource, MenuCategoriesTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (nonatomic, strong) NSArray *arrayWACategory;

@end

@implementation MenuCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    
    [_categoryTableView registerClass:[MenuCategoriesTableViewCell class] forCellReuseIdentifier:@"MenuCategoriesTableViewCell"];
    UINib *cellNibMenuCategoriesTableViewCell = [UINib nibWithNibName:@"MenuCategoriesTableViewCell" bundle:nil];
    [_categoryTableView registerNib:cellNibMenuCategoriesTableViewCell forCellReuseIdentifier:@"MenuCategoriesTableViewCell"];
    
    [self getCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setWaRestaurant:(WARestaurant *)waRestaurant {

    _waRestaurant = waRestaurant;
}
- (void) getCategories {
    
    [Query getCategoryForRestaurant:_waRestaurant skip:skipCount limit:limitCount withSuccess:^(NSArray *items, NSError *error) {
       
        _arrayWACategory = items;
        [_categoryTableView reloadData];
        
    }];
}
#pragma mark Tabel delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return  [_arrayWACategory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCategoriesTableViewCell";
    
    MenuCategoriesTableViewCell *cell = (MenuCategoriesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        cell = [[MenuCategoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.delegate = self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setWaCategory:_arrayWACategory[indexPath.row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    NSLog(@"%li", (long)indexPath.row);
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductViewController *productViewController = [[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
    productViewController.waCategory = _arrayWACategory[indexPath.row];
    
    [self.navigationController pushViewController:productViewController animated:YES];
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

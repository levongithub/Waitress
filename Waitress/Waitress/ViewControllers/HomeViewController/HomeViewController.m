//
//  HomeViewController.m
//  Waitress
//
//  Created by Levon on 12/11/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "HomeViewController.h"
#import "RestaurantTableViewCell.h"
#import "Query.h"
#import "MenuCategoriesViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate ,RestaurantTableViewCellDelegate>{
    
    __weak IBOutlet UITableView *mainTableView;
    
    NSArray *arrayWARestaurant;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    [mainTableView registerClass:[RestaurantTableViewCell class] forCellReuseIdentifier:@"RestaurantTableViewCell"];
    UINib *cellNibRestaurantTableViewCell = [UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil];
    [mainTableView registerNib:cellNibRestaurantTableViewCell forCellReuseIdentifier:@"RestaurantTableViewCell"];
    
    [self getWARestaurant];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getWARestaurant {
    
    [Query getRestaurantskip:skipCount limit:limitCount withSuccess:^(NSArray *items, NSError *error) {
        
        arrayWARestaurant = items;
        [mainTableView reloadData];
        
    }];
}

#pragma mark Tabel delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  arrayWARestaurant.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RestaurantTableViewCell";
    
    RestaurantTableViewCell *cell = (RestaurantTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[RestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.delegate = self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setWaRestaurant:arrayWARestaurant[indexPath.row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    MenuCategoriesViewController *menuCategoriesViewController = [[MenuCategoriesViewController alloc] initWithNibName:@"MenuCategoriesViewController" bundle:nil];
    [menuCategoriesViewController setWaRestaurant:arrayWARestaurant[[indexPath row]]];
    
    [self.navigationController pushViewController:menuCategoriesViewController animated:YES];
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

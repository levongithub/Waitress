//
//  HomeViewController.m
//  Waitress
//
//  Created by Levon on 12/11/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *mainTableView;
    
    NSArray *arrayRestaurant;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
//    [followingTableView registerClass:[FollowingTableViewCell class] forCellReuseIdentifier:@"FollowingTableViewCell"];
//    UINib *cellNibFollowingTableViewCell = [UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil];
//    [followingTableView registerNib:cellNibFollowingTableViewCell forCellReuseIdentifier:@"FollowingTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Tabel delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arrayRestaurant.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FollowingTableViewCell";
    
    return [[UITableViewCell alloc] init];
    
//    FollowingTableViewCell *cell = (FollowingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    
//    if (cell == nil) {
//        cell = [[FollowingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    cell.delegate = self;
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [cell setUser:itemsArray[indexPath.row]];
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}
//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] init];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_MIN_LENGTH - 60, 30)];
//    [label setText:[NSString stringWithFormat:@"following %lu people",(unsigned long)followings.count]];
//    [label setTextColor:[UIColor colorWithWhite:0.5 alpha:1.0f]];
//    [view addSubview:label];
//    return view;
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
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

//
//  AppDelegate.h
//  Waitress
//
//  Created by Levon on 12/11/15.
//  Copyright © 2015 Waitress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HomeViewController *homeViewController;

@end


//
//  ViewController.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "ViewController.h"
#import "FocusViewController.h"
#import "HeroViewController.h"
#import "CommentateViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FocusViewController *focusViewController = [[FocusViewController alloc] init];
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:focusViewController];
    navController1.navigationBar.barTintColor = [UIColor redColor];
    
//    navController1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"焦点视频" image:[UIImage imageNamed:@"focus_normal.png"] selectedImage:[UIImage imageNamed:@"focus_selected"]];
    navController1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"焦点视频" image:[UIImage imageNamed:@"11.tiff"] tag:101];
    
    
    HeroViewController *heroViewController = [[HeroViewController alloc] init];
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:heroViewController];
    navController2.navigationBar.barTintColor = [UIColor redColor];
//    navController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"英雄" image:[UIImage imageNamed:@"hero_normal"] selectedImage:[UIImage imageNamed:@"hero_selected"]];
    navController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"英雄" image:[UIImage imageNamed:@"33.tiff"] tag:102];
    
    CommentateViewController *commentateViewController = [[CommentateViewController alloc] init];
    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:commentateViewController];
    navController3.navigationBar.barTintColor = [UIColor redColor];
//    navController3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"解说" image:[UIImage imageNamed:@"say_normal"] selectedImage:[UIImage imageNamed:@"say_selected"]];
    navController3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"解说" image:[UIImage imageNamed:@"22.tiff"] tag:103];
    
    self.viewControllers = @[navController1, navController2, navController3];
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

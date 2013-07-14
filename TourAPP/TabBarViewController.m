//
//  TabBarViewController.m
//  TourAPP
//
//  Created by 徐彪 on 13-6-21.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainViewController.h"
#import "EquipmentViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        MainViewController *main1=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
        UITabBarItem *maintabbaritem1=[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:100];
        main1.tabBarItem=maintabbaritem1;
        
        EquipmentViewController *equipment=[[EquipmentViewController alloc]init];
        UINavigationController *equipnav=[[UINavigationController alloc]initWithRootViewController:equipment];
        [equipnav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
        
        
        UITabBarItem *maintabbaritem2=[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:101];
        equipnav.tabBarItem=maintabbaritem2;
        self.viewControllers=@[equipnav];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

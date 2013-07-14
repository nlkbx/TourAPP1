//
//  ItemDetailViewController.m
//  TourAPP
//
//  Created by 徐彪 on 13-7-11.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController
@synthesize item;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"宝贝详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [backimage addGestureRecognizer:tap];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:backimage];
    
    
	self.navigationItem.leftBarButtonItem=back;

	// Do any additional setup after loading the view.
}
-(void)back{
    
    //    waterflow.continueLoadData=YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

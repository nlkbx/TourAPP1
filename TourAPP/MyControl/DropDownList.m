//
//  DropDownList.m
//  dropdownTest
//
//  Created by 徐彪 on 13-6-25.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "DropDownList.h"

@implementation DropDownList
@synthesize dataSource,tableHeight,delegate;
- (id)initWithFrame:(CGRect)frame dataSource:(NSArray*) dataSource delegate:(id<DropDownListDelegate>) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate=delegate;
        CGRect screen=[UIScreen mainScreen].bounds;
        // Initialization code
        tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height, screen.size.width, 0.0f)];
        tableview.dataSource=self;
        tableview.delegate=self;
        self.dataSource=dataSource;
        
        tableHeight=dataSource.count*30;
        isshow=NO;
        view=[[Label_IconView alloc]initWithFrame:frame];
        view.margin=10;
        view.backgroudImage=[UIImage imageNamed:@"lightblack"];
        view.text=self.dataSource[0];
        view.textcolor=[UIColor grayColor];
        view.iconImage=[UIImage imageNamed:@"down"];
        [self addSubview:view];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
        [view addGestureRecognizer:tap];

    }
    return self;
}

-(void)click{
    if(!isshow)
    {
        
        view.backgroudImage=[UIImage imageNamed:@"black"];
        view.iconImage=[UIImage imageNamed:@"up"];
        if(self.superview!=nil)
           [ self.superview addSubview:tableview];
        [tableview reloadData];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        tableview.frame=CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y, tableview.frame.size.width,tableHeight);
        [UIView commitAnimations];
    }else{
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        tableview.frame=CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y, tableview.frame.size.width,0.0f);
        [UIView commitAnimations];
        view.backgroudImage=[UIImage imageNamed:@"lightblack"];
        view.iconImage=[UIImage imageNamed:@"down"];
        if(tableview.superview !=nil)
            [ tableview removeFromSuperview];
    }
    isshow=!isshow;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Label_IconView *labelicon;
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        labelicon=[[Label_IconView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, 30)];
        [cell.contentView addSubview:labelicon];
    }else{
        labelicon=cell.contentView.subviews[0];
    }
    labelicon.text=dataSource[indexPath.row];
    if(selectindex==indexPath.row){
        labelicon.textcolor=[UIColor blueColor];
        labelicon.iconImage=[UIImage imageNamed:@"gou"];
    }else{
        labelicon.textcolor=[UIColor blackColor];
        labelicon.iconImage=nil;
    }
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self click];
    view.text=dataSource[indexPath.row];
    [self.delegate SelectIndexChanged:indexPath.row];
    selectindex=indexPath.row;
    
    
}
@end

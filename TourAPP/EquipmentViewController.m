//
//  EquipmentViewController.m
//  TourAPP
//
//  Created by 徐彪 on 13-6-24.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "EquipmentViewController.h"
#import "Equipment.h"
#import "itemListViewController.h"
@interface EquipmentViewController ()

@end

@implementation EquipmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"装备库";
        dm=[[DataManage alloc]init];
        dm.delegate=self;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   [self searchEquipMents];
    DropDownList *dropdownlist=[[DropDownList alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30) dataSource:equipmentNames delegate:self];
    [self.view addSubview:dropdownlist];
  
    tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREENWIDTH, SCREENHEIGHT-44-20-49-30)];
    [self.view addSubview:tableview];
    tableview.dataSource=self;
    tableview.delegate=self;
    // Do any additional setup after loading the view from its nib.
}
-(void)searchEquipMents{
    equipmentArr=[dm Query:EQUIPMENT forTag:100 userInfo:nil];
    childrenEquipment=[[NSMutableArray alloc]initWithCapacity:equipmentArr.count];
    NSSortDescriptor *sort=[[NSSortDescriptor alloc]initWithKey:@"eid" ascending:YES];
    for (Equipment *equ in equipmentArr) {
        NSArray *arr=[equ.equipment_equipments allObjects];
        arr=[arr sortedArrayUsingDescriptors:@[sort]];
        [childrenEquipment addObject:arr];
    }
    
    equipmentNames=[[NSMutableArray alloc]initWithCapacity:equipmentArr.count+1];
    [equipmentNames addObject:@"全部"];
    for (Equipment *equ in equipmentArr) {
        [equipmentNames addObject:[equ ename]];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)SelectIndexChanged:(NSInteger)index{
    if(index!=0){
        
        [tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index-1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
-(void)configurationQueryParameters:(NSFetchRequest *)fetchRequest forTag:(NSInteger)tag userInfo:(id)userInfo{
    if (tag==100) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"eqiupments_equipment == null"];
        [fetchRequest setPredicate:pre];
        NSSortDescriptor *sort=[[NSSortDescriptor alloc]initWithKey:@"eid" ascending:YES];
        [fetchRequest setSortDescriptors:@[sort]];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  equipmentArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     Equipment *equipment=equipmentArr[section];
    return equipment.ename;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Equipment *equipment=equipmentArr[section];
    return equipment.equipment_equipments.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Equipment *equipment=equipmentArr[indexPath.section];
    Equipment *children= childrenEquipment[indexPath.section][indexPath.row];
    cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellback"]];
    cell.textLabel.text=children.ename;
    cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    itemListViewController *itemlist=[[itemListViewController alloc]init];
    Equipment *equipment=equipmentArr[indexPath.section];
    Equipment *children= childrenEquipment[indexPath.section][indexPath.row];
    CGRect rect=self.view.bounds;
    itemlist.equipment=children;
    [self.navigationController pushViewController:itemlist animated:YES];
    
    [tableView reloadData];
    
}
@end

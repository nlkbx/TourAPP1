//
//  EquipmentViewController.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-24.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManage.h"
#import "DropDownList.h"
@interface EquipmentViewController : UIViewController<DataManageDelegate,DropDownListDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray* equipmentArr;
    NSMutableArray *childrenEquipment;
    NSMutableArray* equipmentNames;
    DataManage *dm;
    UITableView *tableview;
    
}
@end

//
//  itemListViewController.h
//  TourAPP
//
//  Created by 尚德机构 on 13-6-29.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Equipment.h"
#import "WaterFlowView.h"
#import "DropDownList.h"
@class Taobao_item_prop;
@interface itemListViewController : UIViewController<WaterFlowViewDelegate,DropDownViewDelegate,UITableViewDataSource,UITableViewDelegate,DropDownListDelegate,DropDownViewDelegate>
{
    
    UIImageView *load;
    NSMutableArray *items;
    WaterFlowView *waterflow;
    NSMutableArray* filteritems;
    NSInteger loaedindex;
    NSInteger hadloadcount;
    NSMutableArray *loadDataImages;
    NSArray* sortArr;
    NSInteger sortindex;
    Taobao_item_prop* item_prop;
    NSMutableDictionary* brands;
  
}
@property (nonatomic,retain)Equipment *equipment;
@end

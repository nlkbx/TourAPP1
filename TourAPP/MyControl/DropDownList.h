//
//  DropDownList1.h
//  TourAPP
//
//  Created by 徐彪 on 13-7-15.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "DropDownView.h"
#import "Label_IconView.h"
@protocol DropDownListDelegate;
@interface DropDownList : DropDownView<UITableViewDelegate,UITableViewDataSource,DropDownViewDelegate>
{
    UITableView *tableView;
    NSMutableArray* selectindexs;
    BOOL selectedChanged;
}

@property(nonatomic,assign)BOOL multselect;
@property(nonatomic,assign)BOOL firstSelectIsAll;
@property(nonatomic,retain)NSArray* dataSource;
@property(nonatomic,assign)CGFloat tableViewHeight;
@property(nonatomic,assign)CGFloat tableViewCellHeight;
@property(nonatomic,retain)UIColor* selectedTextColor;
@property(nonatomic,retain)UIImage* selectedTextIcon;
@property(nonatomic,assign)id<DropDownListDelegate> dropDownListDelegate;
- (id)initWithMainView:(Label_IconView*)mainview;
@end
@protocol DropDownListDelegate <NSObject>
- (void) SelectIndexChanged:(NSInteger)index forDropDownList:(DropDownList*) dropdownlist;
-(void)tableViewDisappear:(NSArray*) selectindexs forDropDownList:(DropDownList*) dropdownlist;
@end
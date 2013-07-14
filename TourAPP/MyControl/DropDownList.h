//
//  DropDownList.h
//  dropdownTest
//
//  Created by 徐彪 on 13-6-25.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Label_IconView.h"
#import "DropDownView.h"
@protocol DropDownListDelegate
- (void) SelectIndexChanged:(NSInteger)index;
@end
@interface DropDownList :DropDownView <UITableViewDelegate,UITableViewDataSource,DropDownViewDelegate>
{
    UITableView *tableview;
    NSInteger selectindex;
    Label_IconView *view;
}

@property(nonatomic,assign)CGFloat tableHeight;
@property(nonatomic,retain)NSArray* dataSource;
@property(nonatomic,assign)id<DropDownListDelegate> delegate;
- (id)initWithFrame:(CGRect)frame dataSource:(NSArray*) dataSource delegate:(id<DropDownListDelegate>) delegate;



@end

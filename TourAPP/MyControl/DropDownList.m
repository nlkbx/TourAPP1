//
//  DropDownList1.m
//  TourAPP
//
//  Created by 徐彪 on 13-7-15.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "DropDownList.h"

@implementation DropDownList
@synthesize tableViewHeight,dataSource,tableViewCellHeight,selectedTextColor,selectedTextIcon,dropDownListDelegate,firstSelectIsAll;
- (id)initWithMainView:(Label_IconView*)mainview
{
    self = [super initWithMainView:mainview];
    if (self) {
        tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, 0)];
        tableView.dataSource=self;
        tableView.delegate=self;
        self.downview=tableView;
        self.tableViewCellHeight=40;
        selectedTextIcon=[UIImage imageNamed:@"gou"];
        selectedTextColor=[UIColor blueColor];
        self.multselect=NO;
        self.firstSelectIsAll=YES;
        selectedChanged=NO;
        self.dropDownViewDelegate=self;
    }
    return self;
}
-(void)setDataSource:(NSArray *)_dataSource{
    dataSource=_dataSource;
    if(dataSource.count!=0){
        selectindexs=[[NSMutableArray alloc]initWithCapacity:1];
        [selectindexs addObject:[NSNumber numberWithInt:0]];
    }
}
-(void)selectAll{
    if(self.multselect)
    {
        [selectindexs removeAllObjects];
        for(NSInteger i=0;i<dataSource.count;i++){
            [selectindexs addObject:[NSNumber numberWithInteger:i]];
            [tableView reloadData];
        }
    }
}
-(void)setTableViewHeight:(CGFloat)_tableViewHeight{
    tableViewHeight=_tableViewHeight;
    downviewheight=tableViewHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableViewCellHeight;
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
        labelicon=[[Label_IconView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, tableViewCellHeight)];
        [cell.contentView addSubview:labelicon];
    }else{
        labelicon=cell.contentView.subviews[0];
    }
    labelicon.text=dataSource[indexPath.row];
    BOOL isselected=NO;
    for (NSNumber* selected in selectindexs) {
        if(indexPath.row==[selected integerValue])
        {
            isselected=YES;
            break;
        }
    }
    if(isselected){
        labelicon.textcolor=selectedTextColor;
        labelicon.iconImage=selectedTextIcon;
    }else{
        labelicon.textcolor=[UIColor blackColor];
        labelicon.iconImage=nil;
    }
       // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Label_IconView *mainview=self.mainview;
       
    if(self.multselect==NO){
        if(selectindexs.count==1){
            NSNumber *indexnumber=selectindexs[0];
            NSUInteger index=[indexnumber integerValue];
            if(index!=indexPath.row)
                selectedChanged=YES;
        }
        [selectindexs removeAllObjects];
        [selectindexs addObject:[NSNumber numberWithInteger:indexPath.row]];
        mainview.text=dataSource[indexPath.row];
       [self hiddenDownView];
        
    }else{
        selectedChanged=YES;
        
        if(firstSelectIsAll&&indexPath.row==0){
            mainview.text=dataSource[indexPath.row];
            [selectindexs removeAllObjects];
            [selectindexs addObject:[NSNumber numberWithInteger:0]];
        }else{
            BOOL isselected=NO;
            NSNumber* selectNumber;
            for (NSNumber * select in selectindexs) {
                if ([select integerValue]==indexPath.row) {
                    isselected=YES;
                    selectNumber=select;
                }else if(firstSelectIsAll&&[select integerValue]==0){
                    [selectindexs removeObject:select];
                }
            }
            if(!isselected)
                [selectindexs addObject:[NSNumber numberWithInteger:indexPath.row]];
            else{
                [selectindexs removeObject:selectNumber];
            }

        }
            mainview.text=@"";
        for (NSInteger i=0;i<selectindexs.count;i++) {
            NSNumber *select=selectindexs[i];
            if(i==0)
                mainview.text=dataSource[[select integerValue]];
            else
                mainview.text=[NSString stringWithFormat:@"%@,%@",mainview.text, dataSource[[select integerValue]]];
        }
    }
    [tableView reloadData];
}

-(void)hiddenDownView{
    [super hiddenDownView];
    if(selectedChanged&&[dropDownListDelegate respondsToSelector:@selector(tableViewDisappear:forDropDownList:)]){
        [self.dropDownListDelegate tableViewDisappear:selectindexs forDropDownList:self];
        selectedChanged=NO;
    }
}
@end

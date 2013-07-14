//
//  WaterFlowView.h
//  WaterFlowView
//
//  Created by 徐彪 on 13-7-7.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowCell.h"
@protocol WaterFlowViewDelegate;

@interface WaterFlowView : UIScrollView<UIScrollViewDelegate>
{
    UIView *headerview;
    UIView *footview;
    NSInteger _colunmCount;
    NSMutableArray *colunmHeights;
    float minHeight;
    NSInteger mincolunm;
    float _separation;
    

    
}
@property(nonatomic,retain)NSMutableArray *cells;
@property(nonatomic, assign)BOOL continueLoadData;
@property(nonatomic,assign)id<WaterFlowViewDelegate> waterFlowViewDelegate;
@property(nonatomic,retain)UIView *footview;


- (id)initWithFrame:(CGRect)frame columnCount:(NSInteger)colunmCount separation:(float)separation;
-(void)insertCell:(WaterFlowCell*) cell;
@end

@protocol WaterFlowViewDelegate<NSObject>;
@optional
-(void)continueLoadData:(WaterFlowView*) waterflow;
@end;


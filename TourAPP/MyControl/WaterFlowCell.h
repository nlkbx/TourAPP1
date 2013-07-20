//
//  WaterFlowCell.h
//  WaterFlowView
//
//  Created by 徐彪 on 13-7-8.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <UIKit/UIKit.h>
enum {
    LeftTop=0,
    RightTop=1,
    LeftBottom=2,
    RightBottom=3
};
typedef NSUInteger LabelViewLocation;
@interface WaterFlowCell : UIView
@property(nonatomic,retain)UIView *contentView;
@property(nonatomic,retain)UIView *labelView;
@property(nonatomic,assign)LabelViewLocation labelViewLocation;
@property(nonatomic,retain)id item;
@end

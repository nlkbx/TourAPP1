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
#import "DropDownView.h"
@interface itemListViewController : UIViewController<WaterFlowViewDelegate,DropDownViewDelegate>
{
    
    UIActivityIndicatorView *load;
    NSMutableArray *items;
    WaterFlowView *waterflow;
    NSMutableArray *watercells;
    NSMutableArray* filteritems;
    NSInteger loaedindex;
    NSInteger hadloadcount;
    NSMutableArray *loadDataImages;

}
@property (nonatomic,retain)Equipment *equipment;
@end

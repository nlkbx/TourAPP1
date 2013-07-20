//
//  DropDownView.h
//  TourAPP
//
//  Created by 徐彪 on 13-7-13.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DropDownViewDelegate;

@interface DropDownView : UIView
{
    CGFloat downviewheight;
     BOOL isshow;
}
@property(nonatomic,retain)UIView *mainview;
@property(nonatomic,retain)UIView *downview;
@property(nonatomic,assign)id<DropDownViewDelegate> dropDownViewDelegate;

- (id)initWithMainView:(UIView*)mainview;

-(void)hiddenDownView;

@end
@protocol DropDownViewDelegate<NSObject>
- (void) showDownView:(DropDownView*)view;
-(void)hiddenDownView:(DropDownView*)view;
@end
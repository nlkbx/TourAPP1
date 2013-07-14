//
//  Label_IconView.h
//  dropdownTest
//
//  Created by 徐彪 on 13-6-25.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Label_IconView : UIView
{
    UIImageView *backgroudview;
    UIImageView *iconview;
    UILabel *label;
    
}
@property(nonatomic,retain)UIImage* backgroudImage;
@property(nonatomic,copy)NSString* text;
@property(nonatomic,retain)UIColor* textcolor;
@property(nonatomic,retain)UIImage* iconImage;
@property(nonatomic,assign)CGFloat margin;
@property(nonatomic,assign)CGSize iconsize;
@end

//
//  WaterFlowCell.m
//  WaterFlowView
//
//  Created by 徐彪 on 13-7-8.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "WaterFlowCell.h"

@implementation WaterFlowCell
@synthesize contentView,labelView,labelViewLocation,item;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
    }
    return self;
}
-(void)setContentView:(UIView *)_contentView{
    contentView=_contentView;
    self.contentView.frame=CGRectMake(0,0,self.contentView.frame.size.width, self.contentView.frame.size.height);
    self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y, self.contentView.frame.size.width,self.contentView.frame.size.height);
    [self addSubview:self.contentView];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


@end

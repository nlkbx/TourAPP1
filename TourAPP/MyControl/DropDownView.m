//
//  DropDownView.m
//  TourAPP
//
//  Created by 徐彪 on 13-7-13.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "DropDownView.h"

@implementation DropDownView
@synthesize mainview,downview,dropDownViewDelegate;
- (id)initWithMainView:(UIView*)mainview
{
    self = [super initWithFrame:mainview.frame];
    if (self) {
        [self setMainview:mainview];
        isshow=NO;
    }
    return self;
}
-(void)setMainview:(UIView *)_mainview{
    mainview=_mainview;
    self.mainview.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:mainview];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    for (UIGestureRecognizer *ge in mainview.gestureRecognizers) {
        [mainview removeGestureRecognizer:ge];
    }
    [mainview addGestureRecognizer:tap];
}
-(void)setDownview:(UIView *)_downview{
    downview=_downview;
    downviewheight=downview.frame.size.height;
}
-(void)click{
    if(self.downview)
    {
        if(!isshow)
        {
            if(self.superview!=nil)
            [ self.superview addSubview:downview];
          
            downview.frame=CGRectMake(downview.frame.origin.x,self.frame.origin.y+self.frame.size.height, downview.frame.size.width, 0);
            [self.superview addSubview:downview];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            downview.frame=CGRectMake(downview.frame.origin.x,self.frame.origin.y+self.frame.size.height, downview.frame.size.width,downviewheight);
            [UIView commitAnimations];
            if([dropDownViewDelegate respondsToSelector:@selector(showDownView:)]){
                [dropDownViewDelegate showDownView:self];
            }
            isshow=YES;
        }else{
            [self hiddenDownView];
        }
        
    }
}
-(void)hiddenDownView{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    downview.frame=CGRectMake(downview.frame.origin.x,self.frame.origin.y+self.frame.size.height, downview.frame.size.width, 0);
    [UIView commitAnimations];
    
    if(downview.superview !=nil)
        [downview removeFromSuperview];
    if([dropDownViewDelegate respondsToSelector:@selector(hiddenDownView:)]){
        [dropDownViewDelegate hiddenDownView:self];
    }
    isshow=NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

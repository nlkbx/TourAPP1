//
//  Label_IconView.m
//  dropdownTest
//
//  Created by 徐彪 on 13-6-25.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "Label_IconView.h"

@implementation Label_IconView
@synthesize backgroudImage,iconImage,text,textcolor,margin,iconsize;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGSize viewsize=frame.size;
         margin=10.0f;
        backgroudview=[[UIImageView alloc]init];
        [self addSubview:backgroudview];
        iconsize=CGSizeMake(viewsize.height/3*2, viewsize.height/2);
        iconview=[[UIImageView alloc]init]      ;
        [self addSubview:iconview];
        label=[[UILabel alloc]init];
        label.backgroundColor=[UIColor clearColor];
        

        [self addSubview:label];
        [self setframe];
            }
    return self;
}

-(void)setBackgroudImage:(UIImage *)_backgroudImage{
    backgroudImage=_backgroudImage;
     backgroudview.image=backgroudImage;
}
-(void)setIconImage:(UIImage *)_iconImage{
    iconImage=_iconImage;
    iconview.image=iconImage;
}
-(void)setText:(NSString *)_text{
    text=_text;
    label.text=text;
}
-(void)setMargin:(CGFloat)_margin{
    margin=_margin;
    [self setframe];
}
-(void)setIconsize:(CGSize)_iconsize{
    iconsize=_iconsize;
    [self setframe];
}
-(void)setFrame:(CGRect)_frame{
    [super setFrame:_frame];
    [self setframe];
}
-(void)setTextcolor:(UIColor *)_textcolor{
    textcolor=_textcolor;
    label.textColor=textcolor;
}
-(void)setframe{
    CGSize viewsize=self.frame.size;
    backgroudview.frame=CGRectMake(0, 0, viewsize.width, viewsize.height);
    iconview.frame=CGRectMake(viewsize.width-margin-iconsize.width, (viewsize.height-iconsize.height)/2, iconsize.width,iconsize.height);
    label.frame=CGRectMake(margin, 0,iconview.frame.origin.x-margin, viewsize.height);
    label.font=[UIFont boldSystemFontOfSize:viewsize.height/2];
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

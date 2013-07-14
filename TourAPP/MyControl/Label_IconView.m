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
        [self addObserver:self forKeyPath:@"backgroudImage" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"iconImage" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"margin" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"iconsize" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"textcolor" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath compare:@"backgroudImage"]==NSOrderedSame){
        backgroudview.image=backgroudImage;
    }else if([keyPath compare:@"iconImage"]==NSOrderedSame){
        iconview.image=iconImage;
    }else if([keyPath compare:@"text"]==NSOrderedSame){
        label.text=text;
    }else if([keyPath compare:@"margin"]==NSOrderedSame){
        [self setframe];
    }else if([keyPath compare:@"iconsize"]==NSOrderedSame){
        [self setframe];
    }  else if([keyPath compare:@"textcolor"]==NSOrderedSame){
        label.textColor=textcolor;
        
    }else if([keyPath compare:@"frame"]==NSOrderedSame){
        [self setframe];
        
    }
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

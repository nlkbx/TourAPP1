//
//  WaterFlowView.m
//  WaterFlowView
//
//  Created by 徐彪 on 13-7-7.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "WaterFlowView.h"

@implementation WaterFlowView
@synthesize cells,continueLoadData,waterFlowViewDelegate,footview;
- (id)initWithFrame:(CGRect)frame columnCount:(NSInteger)colunmCount separation:(float)separation
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _colunmCount=colunmCount;
        _separation=separation;
        colunmHeights=[[NSMutableArray alloc]initWithCapacity:_colunmCount];
        for (int i=0;i<_colunmCount;i++){
            [colunmHeights addObject:[NSNumber numberWithInt:0]];
        }
        self.delegate=self;
        self.continueLoadData=YES;
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectZero];
        label.text=@"加载中...";
        label.textColor=[UIColor grayColor];
        [label sizeToFit];
        self.footview=label;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)setCells:(NSMutableArray *)_cells{
    cells=_cells;
    [self addCells:0];
}
-(void)insertCell:(WaterFlowCell *)cell{
    [cells addObject:cell];
    [self addCells:cells.count-1];
}
-(void)setFootview:(UIView *)_footview{
    footview=_footview;
    footview.frame=CGRectZero;
}
-(void)addCells:(NSInteger) startIndex{
    CGFloat colunmwidth=(self.frame.size.width-(_colunmCount+1)*_separation)/_colunmCount;

    for(int i=startIndex;i<cells.count;i++) {
        WaterFlowCell *cell=cells[i];
        [self changeCellScale:colunmwidth cell:cell];
        for(NSInteger i=0;i<_colunmCount;i++){
            NSNumber *h=colunmHeights[i];
            float height=[h floatValue];
            if(minHeight>height){
                minHeight=height;
                mincolunm=i;
            }
        }
        cell.frame=CGRectMake(colunmwidth*mincolunm+(mincolunm+1)*_separation, minHeight+_separation,cell.frame.size.width, cell.frame.size.height);
      
        minHeight=minHeight+cell.frame.size.height+_separation;
        colunmHeights[mincolunm]=[NSNumber numberWithFloat:minHeight];
        [self addSubview:cell];
        if(cell.labelView){
            switch (cell.labelViewLocation) {
                case LeftTop:
                    cell.labelView.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y,cell.labelView.frame.size.width, cell.labelView.frame.size.height);
                    [ self addSubview:cell.labelView];
                    break;
                case LeftBottom:
                    cell.labelView.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y+cell.frame.size.height-cell.labelView.frame.size.height,cell.labelView.frame.size.width, cell.labelView.frame.size.height);
                    [ self addSubview:cell.labelView];
                    break;
                case RightTop:
                    cell.labelView.frame=CGRectMake(cell.frame.origin.x+cell.frame.size.width-cell.labelView.frame.size.width, cell.frame.origin.y,cell.labelView.frame.size.width, cell.labelView.frame.size.height);
                    [ self addSubview:cell.labelView];
                    break;
                case RightBottom:
                    cell.labelView.frame=CGRectMake(cell.frame.origin.x+cell.frame.size.width-cell.labelView.frame.size.width, cell.frame.origin.y+cell.frame.size.height-cell.labelView.frame.size.height,cell.labelView.frame.size.width, cell.labelView.frame.size.height);
                    [ self addSubview:cell.labelView];
                    break;
                default:
                    break;
            }
        }
    }
    float max=0;
    for(NSInteger i=0;i<_colunmCount;i++){
        NSNumber *h=colunmHeights[i];
        float height=[h floatValue];
        if(max<height){
            max=height;
        }
    }
    self.contentSize=CGSizeMake(self.frame.size.width,max);
    if(footview&&self.contentSize.height>self.frame.size.height){
        footview.frame=CGRectMake(self.frame.size.width/2-footview.frame.size.width/2, self.contentSize.height+10, footview.frame.size.width, footview.frame.size.height);
        if(footview.superview==nil)
        [self addSubview:footview];
    }
}
-(void)changeCellScale:(CGFloat) colunmwidth cell:(UIView*) cell {
    CGFloat scale=colunmwidth/cell.frame.size.width;
    cell.transform= CGAffineTransformScale(cell.transform, scale, scale);
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidScroll:Point:(%f,%f)",scrollView.contentOffset.x,scrollView.contentOffset.y+scrollView.frame.size.height);
    if (scrollView.contentOffset.y+scrollView.frame.size.height>self.contentSize.height) {
        if(continueLoadData){
       
                    if ([waterFlowViewDelegate respondsToSelector:@selector(continueLoadData:)]) {
                   
                        [NSThread detachNewThreadSelector:@selector(loadNewData) toTarget:self withObject:nil];
//                    [self loadNewData];
                }
         
        }
    }
//    if(continueLoadData &&!isloading&&scrollView.contentOffset.y+scrollView.frame.size.height>self.contentSize.height&&[waterFlowViewDelegate respondsToSelector:@selector(continueLoadData:)])
//    {
//       
//        isloading=YES;
//        [self loadNewData];
//    }
    
    
}// any offset changes
-(void)loadNewData{
    continueLoadData=NO;
    [waterFlowViewDelegate continueLoadData:self];
    
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}// return a yes if you want to scroll to the top. if not defined, assumes YES


@end

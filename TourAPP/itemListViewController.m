//
//  itemListViewController.m
//  TourAPP
//
//  Created by 尚德机构 on 13-6-29.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "itemListViewController.h"
#import "TopSDKBundle.h"
#import "ProjectPublicMethod.h"
#import "Taobao_item.h"
#import "ToolMethod.h"
#import "UIImageView+AFNetworking.h"
#import "AFImageRequestOperation.h"
#import "ItemDetailViewController.h"
#import "Label_IconView.h"
@interface itemListViewController ()

@end

@implementation itemListViewController
@synthesize equipment;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"商品列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ProjectPublicMethod checkNetworkStatus:TAOBAOHOST target:self success:@selector(connectHost) fail:@selector(failConnect)];
    UIImageView *backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [backimage addGestureRecognizer:tap];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:backimage];
	self.navigationItem.leftBarButtonItem=back;
    Label_IconView *mainview=[[Label_IconView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH/2-2, 30)];
    mainview.margin=10;
    mainview.backgroudImage=[UIImage imageNamed:@"lightblack"];
    mainview.text=@"排序";
    mainview.textcolor=[UIColor grayColor];
    mainview.iconImage=[UIImage imageNamed:@"down"];
    DropDownView *dropdown=[[DropDownView alloc]initWithMainView:mainview];
    dropdown.dropDownViewDelegate=self;
    
    // Do any additional setup after loading the view.
}
//当连上网络时调用
-(void)connectHost{
   
    load=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-25, SCREENHEIGHT/2-98, 50,50)];
    [load startAnimating];
    [self.view addSubview:load];
    [self getItems];

}
-(void)failConnect{
    UIImageView *nonet=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noNet"]];
    nonet.frame=CGRectMake(SCREENWIDTH/4, 50, SCREENWIDTH/2, SCREENWIDTH/2+20);
    [self.view addSubview:nonet];
}

-(void)back{
    for (UIImageView *image in loadDataImages) {
        [image cancelImageRequestOperation];
    }
//    waterflow.continueLoadData=YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getItems{
    TopIOSClient *client =[TopIOSClient getIOSClientByAppKey:APPKEY];
    //http://gw.api.taobao.com/router/rest?sign=CCFE3557C38D740ACBE92B14811A3C26&timestamp=2013-07-07+16%3A07%3A26&v=2.0&app_key=12129701&method=tmall.selected.items.search&partner_id=top-apitools&format=json&cid=50016736
    NSMutableDictionary *params =[[NSMutableDictionary alloc]init];
    [params setObject:equipment.cid forKey:@"cid"];
    [params setObject:@"tmall.selected.items.search" forKey:@"method"];
    [params setObject:@"json" forKey:@"format"];
    [client api:@"GET" params:params target:self cb:@selector(showApiResponse:) userId:@"" needMainThreadCallBack:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showApiResponse:(id)data
{
    if ([data isKindOfClass:[TopApiResponse class]])
    {
        BOOL isfind=NO;
        TopApiResponse *responseobj = (TopApiResponse *)data;
        NSError *error;
        if ([responseobj content])
        {
            
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[[responseobj content] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            
           
            NSArray *dicitems=[ToolMethod PeelOfftheSkin:@[@"tmall_selected_items_search_response",@"item_list",@"selected_item"] dictionary:dic];
            if(dicitems){
                isfind=YES;
                items=[[NSMutableArray alloc]initWithCapacity:dicitems.count];
                for (NSDictionary *dicitem in dicitems) {
                    Taobao_item *item=[ToolMethod NSDictionaryToObject:dicitem ObjectName:@"Taobao_item"];
                    [items addObject:item];
                }
           
            }
            [self getItemsPicAndPrice];
            
        }
        else {
            NSLog(@"%@",[(NSError *)[responseobj error] userInfo]);
        }
        [load removeFromSuperview];
        [load stopAnimating];
        if(isfind==NO){
            [self notfinditem];
        }
    }
    
}
-(void)notfinditem{
    UILabel *label=[[UILabel alloc]init];
    label.text=@"抱歉！没有找到你要的装备";
    label.textColor=[UIColor grayColor];
    [label sizeToFit];
    label.frame=CGRectMake(SCREENWIDTH/2-label.bounds.size.width/2, 50, label.bounds.size.width, label.bounds.size.height);
    [self.view addSubview:label];

}
//获得商品的展示图片，价格以及邮费、折扣等信息
-(void)getItemsPicAndPrice{
    for(int i=0;i<items.count;i+=20)
    [self searchItemsFromIndex:i];
    filteritems=items;
    [self loadWaterFlow];
}

-(void)searchItemsFromIndex:(NSInteger) index{
    TopIOSClient *client =[TopIOSClient getIOSClientByAppKey:APPKEY];
    //http://gw.api.taobao.com/router/rest?sign=C046DF34FDF069DFC1778ADC24B45448&timestamp=2013-07-09+22%3A23%3A18&v=2.0&app_key=21553496&method=taobao.items.list.get&partner_id=top-apitools&format=json&track_iids=16791592866_track_11116,17718030316_track_11116&fields=num_iid,pic_url,price,has_discount,freight_payer,has_invoice,has_warranty,props
    //num_iid,pic_url,price,has_discount打折,freight_payer运费支付,has_invoice发票,has_warranty保修,props类目属性
    NSMutableDictionary *params =[[NSMutableDictionary alloc]init];
    [params setObject:@"taobao.items.list.get" forKey:@"method"];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:@"num_iid,pic_url,price,has_discount,freight_payer,has_invoice,has_warranty,props" forKey:@"fields"];
    NSMutableString *track_iids=[[NSMutableString alloc]init];
    int max=(index+20<items.count?index+20:items.count);
    for (int i=index;i<max;i++) {
        Taobao_item *item=items[i];
        [track_iids appendString:item.track_iid];
        [track_iids appendString:@","];
    }
    track_iids=[track_iids substringToIndex:track_iids.length-1];
    [params setObject:track_iids forKey:@"track_iids"];
      //同步
    TopApiResponse *responseobj =[client api:@"GET" params:params userId:@""];
    NSError *error;
    BOOL isfind=NO;
    if ([responseobj content])
    {

        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[[responseobj content] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        
        
        NSArray *dicitems=[ToolMethod PeelOfftheSkin:@[@"items_list_get_response",@"items",@"item"] dictionary:dic];
        if(dicitems){
            isfind=YES;
        for (int i=0;i<dicitems.count;i++) {
            NSDictionary *dic=dicitems[i];

            
           
            [ToolMethod NSDictionaryToObject:dicitems[i] Object:items[i+index]];
            Taobao_item *item=items[i+index];

        }
        }
        
    }
    else {
        NSLog(@"%@",[(NSError *)[responseobj error] userInfo]);
    }
    if(isfind==NO&&index!=0){
        [self notfinditem];
    }

}
-(void)loadWaterFlow{
    waterflow=[[WaterFlowView alloc]initWithFrame:CGRectMake(0,30, SCREENWIDTH, SCREENHEIGHT-44-20-30-49) columnCount:2 separation:5];
    [self.view addSubview:waterflow];
    waterflow.backgroundColor=[UIColor yellowColor];
    watercells=[[NSMutableArray alloc]initWithCapacity:20];
    waterflow.cells=watercells;
    waterflow.waterFlowViewDelegate=self;
    loadDataImages=[[NSMutableArray alloc]init];
    [self loadcells:0 count:20];
    
}
-(void)loadcells:(NSInteger)index count:(NSInteger)count{
    count=filteritems.count>index+count?index+count:filteritems.count;
    loaedindex=count;
   
    for (int i=index; i<count;i++) {
        UIImageView *imageview=[[UIImageView alloc]init];
        

        Taobao_item *item=filteritems[i];
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:item.pic_url]];
          imageview.tag=i;
        [loadDataImages addObject:imageview];

        [imageview setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            imageview.image=image;
           
            [self insertCell:imageview];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            imageview.image=[UIImage imageNamed:@"nopic"];
            [self insertCell:imageview];
        }];
    }
    
    
  
}
-(void)insertCell:(UIImageView *)imageView{

    [loadDataImages removeObject:imageView];
    NSInteger tag=imageView.tag;
    Taobao_item *item=filteritems[imageView.tag];
    imageView.frame=CGRectMake(0,0, imageView.image.size.width, imageView.image.size.height);
    WaterFlowCell *cell=[[WaterFlowCell alloc]init];
    [cell setContentView:imageView];
    cell.tag=imageView.tag;
    UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(0,0,0,20)];
    price.backgroundColor=[UIColor blackColor];
    price.alpha=0.5;
    price.text=[NSString stringWithFormat:@"￥%d", [item.price integerValue]];
    price.textColor=[UIColor whiteColor];
    price.font=[UIFont systemFontOfSize:20];
    [price sizeToFit];
    cell.labelView=price;
    cell.labelViewLocation=RightBottom;
    [waterflow insertCell:cell];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectItem:)];
    [cell addGestureRecognizer:tap];
    hadloadcount++;
    NSLog(@"已加载%d,计划加载%d,总%d",hadloadcount,loaedindex,filteritems.count);
    if(hadloadcount==loaedindex&&hadloadcount<filteritems.count)
    {
        NSLog(@"继续加载");
        waterflow.continueLoadData=YES;
    }
    if(hadloadcount>=filteritems.count){
        waterflow.continueLoadData=NO;
        NSLog(@"以显示全部商品");
        [self setfootview:@"以显示全部商品"];
        
    }else{
        [self setfootview:@"加载中"];
    }


}
-(void)selectItem:(UIGestureRecognizer*)ges{
    WaterFlowCell *cell=ges.view;
    Taobao_item *item=filteritems[cell.tag];

   CGPoint point= [ges locationInView:waterflow];
    ItemDetailViewController *itemdetail=[[ItemDetailViewController alloc]init];
    itemdetail.item=item;
    [self.navigationController pushViewController:itemdetail animated:YES];

}
-(void)continueLoadData:(WaterFlowView *)waterflow{
    NSLog(@"+++++++++++++++++++++++++++++");
     [self loadcells:waterflow.cells.count count:20];
    
}
-(void)setfootview:(NSString*)text{
    UILabel *foot=waterflow.footview;
    foot.text=text;
    [foot sizeToFit];
     foot.frame=CGRectMake(waterflow.frame.size.width/2-foot.frame.size.width/2, foot.frame.origin.y, foot.frame.size.width, foot.frame.size.height);
}
@end

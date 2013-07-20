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
#import "Taobao_item_prop.h"
#import "prop_value.h"
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
    
    load=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-25, SCREENHEIGHT/2-98, 50,50)];
    [load startAnimating];
    [self.view addSubview:load];
    [ProjectPublicMethod checkNetworkStatus:@"http://www.baidu.com/" target:self success:@selector(connectHost) fail:@selector(connectHost)];
    UIImageView *backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [backimage addGestureRecognizer:tap];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:backimage];
	self.navigationItem.leftBarButtonItem=back;
    
       // Do any additional setup after loading the view.
}
-(void)showDownView:(DropDownView *)view{
    Label_IconView *label_icon=view.mainview;
    label_icon.backgroudImage=[UIImage imageNamed:@"black"];
    label_icon.iconImage=[UIImage imageNamed:@"up"];

}
-(void)hiddenDownView:(DropDownView *)view{
    Label_IconView *label_icon=view.mainview;
    label_icon.backgroudImage=[UIImage imageNamed:@"lightblack"];
    label_icon.iconImage=[UIImage imageNamed:@"down"];
    
}
//当连上网络时调用
-(void)connectHost{
    [self getprops];
    [self getItems];
}
-(void)failConnect{
    UIImageView *nonet=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noNet"]];
    nonet.frame=CGRectMake(SCREENWIDTH/4, 50, SCREENWIDTH/2, SCREENWIDTH/2+20);
    [self.view addSubview:nonet];
}

-(void)back{
    [self stopLoadImage];
//    waterflow.continueLoadData=YES;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getprops{
     TopIOSClient *client =[TopIOSClient getIOSClientByAppKey:APPKEY];
    //http://gw.api.taobao.com/router/rest?sign=CB2FAB2D63CB52B3EA94F4FF9BDF27FE&timestamp=2013-07-16+20%3A55%3A26&v=2.0&app_key=21553496&method=taobao.itemprops.get&partner_id=top-apitools&format=json&cid=50016736&fields=pid,name,prop_values
    NSMutableDictionary *params =[[NSMutableDictionary alloc]init];
    [params setObject:equipment.cid forKey:@"cid"];
    [params setObject:@"taobao.itemprops.get" forKey:@"method"];
    [params setObject:@"json" forKey:@"format"];
    [client api:@"GET" params:params target:self cb:@selector(getpropsresponse:) userId:@"" needMainThreadCallBack:YES];
}
-(void)getpropsresponse:(id)data{
    if ([data isKindOfClass:[TopApiResponse class]])
    {
        BOOL isfind=NO;
        TopApiResponse *responseobj = (TopApiResponse *)data;
        NSError *error;
        if ([responseobj content])
        {
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[[responseobj content] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            NSArray *dicitem_props=[ToolMethod PeelOfftheSkin:@[@"itemprops_get_response",@"item_props",@"item_prop"] dictionary:dic];
            for (NSDictionary *dic in dicitem_props) {
                Taobao_item_prop* props=[ToolMethod NSDictionaryToObject:dic ObjectName:@"Taobao_item_prop"];
                if([props.pid integerValue]==20000){
                    item_prop=props;
                    break;
                }
            }
            
        }
    }
}
-(void)getItems{
    while (item_prop==nil) {
        [NSThread sleepForTimeInterval:0.2];
    }
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
    filteritems=[[NSMutableArray alloc]initWithArray:items];
    [self setBrands];
    [self loadWaterFlow];
   
}
-(NSString*)getBrandId:(NSString*)props{
    SubStringHelper *help1=[[SubStringHelper alloc]initWithSubString:@"20000" before:NO keepsubstring:YES];
    SubStringHelper *help2=[[SubStringHelper alloc]initWithSubString:@";" before:YES keepsubstring:NO];
    SubStringHelper *help3=[[SubStringHelper alloc]initWithSubString:@":" before:NO keepsubstring:NO];
   return  [ToolMethod SubString:props withHelps:@[help1,help2,help3]];

}
-(void)setBrands{
    brands=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *allbrands=[[NSMutableDictionary alloc]initWithCapacity:item_prop.prop_values.prop_value.count];
    for (prop_value * value in item_prop.prop_values.prop_value) {
        [allbrands setObject:value.name forKey:[NSString stringWithFormat:@"%d",[value.vid integerValue]]];
    }
   
    for (Taobao_item* item in items) {
        NSString* brandid=[self getBrandId:item.props];
               NSString* name=[allbrands objectForKey:brandid];
        if(name!=nil)
        {
            [brands setObject:brandid forKey:name];
        
        }
    }
    
    Label_IconView *sortMainView=[ProjectPublicMethod getDropDownViewMainView:@"排序" frame:CGRectMake(0, 0, SCREENWIDTH/2-1, 30)];
    DropDownList *sortdropdown=[[DropDownList alloc]initWithMainView:sortMainView];;
    [self.view addSubview:sortdropdown];
    sortdropdown.tag=100;
    sortArr=@[@"排序",@"价格",@"打折",@"评分",@"包邮",@"有发票",@"保修"];
    sortdropdown.dataSource=sortArr;
    sortdropdown.tableViewHeight=sortdropdown.dataSource.count*30;
    sortdropdown.tableViewCellHeight=30;
    sortdropdown.dropDownListDelegate=self;
    sortdropdown.dropDownViewDelegate=self;
    //    DropDownView *brand=[self setdropdownview:@"品牌" frame:CGRectMake(SCREENWIDTH/2+1, 0, SCREENWIDTH/2-1, 30)];
    UIImageView *separate=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"separate"]];
    separate.frame=CGRectMake(SCREENWIDTH/2-1, 0,2,30);
    [self.view addSubview:separate];

   Label_IconView *brandMainView=[ProjectPublicMethod getDropDownViewMainView:@"全部品牌" frame:CGRectMake(SCREENWIDTH/2+1, 0, SCREENWIDTH/2-1, 30)];
    DropDownList *branddropdown=[[DropDownList alloc]initWithMainView:brandMainView];
    branddropdown.tag=101;
    [self.view addSubview:branddropdown];
    NSMutableArray *datasource=[[NSMutableArray alloc]initWithArray:[brands allKeys] copyItems:YES];
    [datasource insertObject:@"全部品牌" atIndex:0];
    branddropdown.dataSource=datasource;
    branddropdown.tableViewHeight=SCREENHEIGHT-44-20-30-49;
    branddropdown.tableViewCellHeight=30;
    branddropdown.dropDownListDelegate=self;
    branddropdown.dropDownViewDelegate=self;
    branddropdown.multselect=YES;
 
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
        NSLog(@"%@",[responseobj content]);
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
    if(filteritems.count==0){
        [self notfinditem];
    }else{
    waterflow=[[WaterFlowView alloc]initWithFrame:CGRectMake(0,30, SCREENWIDTH, SCREENHEIGHT-44-20-30-49) columnCount:2 separation:5];
    [self.view addSubview:waterflow];
    waterflow.backgroundColor=[UIColor yellowColor];
  
    waterflow.waterFlowViewDelegate=self;
    loadDataImages=[[NSMutableArray alloc]init];
    [self setLoadindex:20];
    waterflow.cells=[[NSMutableArray alloc]initWithCapacity:loaedindex];
    [self loadcell];
    }
    
}
-(void)setLoadindex:(NSInteger)count{
    count=filteritems.count>hadloadcount+count?hadloadcount+count:filteritems.count;
    loaedindex=count;
}
-(void)loadcell{
        UIImageView *imageview=[[UIImageView alloc]init];
        Taobao_item *item=filteritems[hadloadcount];
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:item.pic_url]];
          imageview.tag=hadloadcount;
        [loadDataImages addObject:imageview];

        [imageview setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            imageview.image=image;
            [self insertCell:imageview];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            imageview.image=[UIImage imageNamed:@"nopic"];
            [self insertCell:imageview];
        }];
}
-(void)insertCell:(UIImageView *)imageView{

    [loadDataImages removeObject:imageView];
      Taobao_item *item=filteritems[imageView.tag];
    imageView.frame=CGRectMake(0,0, imageView.image.size.width, imageView.image.size.height);
    WaterFlowCell *cell=[[WaterFlowCell alloc]init];
    [cell setContentView:imageView];
    cell.item=filteritems[imageView.tag ];
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
    NSLog(@"%@",item.props);
    if(hadloadcount<loaedindex)
        [self loadcell];
    if(hadloadcount==loaedindex&&hadloadcount<filteritems.count)
    {
//        NSLog(@"继续加载");
        waterflow.continueLoadData=YES;
    }
    if(hadloadcount>=filteritems.count){
        waterflow.continueLoadData=NO;
//        NSLog(@"以显示全部商品");
        [self setfootview:@"以显示全部商品"];
        
    }else{
        [self setfootview:@"加载中"];
    }


}
-(void)selectItem:(UIGestureRecognizer*)ges{
    WaterFlowCell *cell=ges.view;
    Taobao_item *item=cell.item;
    CGPoint point= [ges locationInView:waterflow];
    ItemDetailViewController *itemdetail=[[ItemDetailViewController alloc]init];
    itemdetail.item=item;
    [self.navigationController pushViewController:itemdetail animated:YES];

}
-(void)continueLoadData:(WaterFlowView *)waterflow{
    NSLog(@"+++++++++++++++++++++++++++++");
    [self setLoadindex:20];
     [self loadcell];
    
}
-(void)setfootview:(NSString*)text{
    UILabel *foot=waterflow.footview;
    foot.text=text;
    [foot sizeToFit];
     foot.frame=CGRectMake(waterflow.frame.size.width/2-foot.frame.size.width/2, foot.frame.origin.y, foot.frame.size.width, foot.frame.size.height);
}
-(void)tableViewDisappear:(NSArray *)selectindexs forDropDownList:(DropDownList *)dropdownlist{
    if(dropdownlist.tag==100){
        if(selectindexs.count!=0){
                NSUInteger index=[ToolMethod getIntegerFromArray:selectindexs index:0];
        if(sortindex!=index&&index!=0){
            sortindex=index;
            [self reloadWaterFlowView];
        }
        }
    }else{
        [self stopLoadImage];
        [filteritems removeAllObjects];
    
        if(selectindexs.count==1){
            
            NSInteger index=[ToolMethod getIntegerFromArray:selectindexs index:0];
             if (index==0) {
                
                [filteritems addObjectsFromArray:items];
                [self reloadWaterFlowView];
                 return;
            }
        }
       
        for (NSInteger i=0;i<selectindexs.count;i++) {
            NSInteger index=[ToolMethod getIntegerFromArray:selectindexs index:i];
            NSLog(@"%d  %d",dropdownlist.dataSource.count,index);
            NSString* brand=dropdownlist.dataSource[index];
            NSString* vid=[brands objectForKey:brand];
            NSLog(@"选中的品牌%@",vid);
            for (Taobao_item *item in items) {
                NSString *itemvid=[self getBrandId:item.props];
                if([itemvid compare:vid]==NSOrderedSame)
                    [filteritems addObject:item];
            }
        }
        [self reloadWaterFlowView];
    }

}

//@[@"排序",@"价格",@"打折",@"评分",@"包邮",@"有发票",@"保修"]
-(void)reloadWaterFlowView{
      if(sortindex==1){
        [filteritems sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            Taobao_item *item1=obj1;
            Taobao_item *item2=obj2;
            if([item1.price floatValue]<=[item2.price floatValue])
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }];
      }else if(sortindex==2){
          [filteritems sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
              Taobao_item *item1=obj1;
              Taobao_item *item2=obj2;
              if(item1.has_discount==YES||item2.has_discount==NO)
                  return NSOrderedAscending;
              else
                  return NSOrderedDescending;
          }];
      }else if(sortindex==3){
          [filteritems sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
              Taobao_item *item1=obj1;
              Taobao_item *item2=obj2;
              if([item1.item_score floatValue]>=[item2.item_score floatValue])
                  return NSOrderedAscending;
              else
                  return NSOrderedDescending;
          }];
      }else if(sortindex==4){
          [filteritems sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
              Taobao_item *item1=obj1;
              Taobao_item *item2=obj2;
              if([item1.freight_payer compare:@"seller"]==NSOrderedSame||[item2.freight_payer compare:@"seller"]!=NSOrderedSame)
                  return NSOrderedAscending;
              else
                  return NSOrderedDescending;
          }];
      }else if(sortindex==5){
          [filteritems sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
              Taobao_item *item1=obj1;
              Taobao_item *item2=obj2;
              if(item1.has_invoice==YES||item2.has_invoice==NO)
                  return NSOrderedAscending;
              else
                  return NSOrderedDescending;
          }];
      }else if(sortindex==6){
          [filteritems sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
              Taobao_item *item1=obj1;
              Taobao_item *item2=obj2;
              if(item1.has_warranty==YES||item2.has_warranty==NO)
                  return NSOrderedAscending;
              else
                  return NSOrderedDescending;
          }];
      }
//    for (Taobao_item *item in filteritems) {
//        NSLog(@"价格%f,打折:%@,评分：%f,包邮:%@,发票:%@,保修%@",[item.price floatValue],item.has_discount?@"有":@"无",[item.item_score floatValue]
//              ,item.freight_payer,item.has_invoice?@"有":@"无",item.has_warranty?@"有":@"无");
//    }
    
    [self stopLoadImage];
    hadloadcount=0;
    [waterflow removeFromSuperview];
    [self loadWaterFlow];
  
}
-(void)stopLoadImage{
    for (UIImageView *image in loadDataImages) {
        [image cancelImageRequestOperation];
    }
}
@end

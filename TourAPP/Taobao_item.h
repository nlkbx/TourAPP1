//
//  Taobao_item.h
//  TourAPP
//
//  Created by 徐彪 on 13-7-7.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Taobao_item : NSObject
@property(nonatomic ,copy)NSString* cid;
@property(nonatomic,copy)NSString *track_iid;
@property(nonatomic,retain)NSNumber *item_score;//评分
@property(nonatomic,copy)NSString *shop_id;
@property(nonatomic,assign)BOOL has_invoice;//发票
@property(nonatomic,copy)NSString *freight_payer;//运费付款人
@property(nonatomic,assign)BOOL  has_warranty;//保修
@property(nonatomic,assign)BOOL  has_discount;//折扣
@property(nonatomic,copy)NSString *num_iid;
@property(nonatomic,copy)NSString *pic_url;
@property(nonatomic,retain)NSNumber *price;
@property(nonatomic,copy)NSString *props;
@end

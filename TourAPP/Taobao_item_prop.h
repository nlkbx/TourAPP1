//
//  Taobao_item_prop.h
//  TourAPP
//
//  Created by 徐彪 on 13-7-16.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "prop_values.h"
@interface Taobao_item_prop : NSObject
@property(nonatomic,retain)prop_values* prop_values;
@property(nonatomic,assign)BOOL multi;
@property(nonatomic,assign)BOOL must;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* pid;
@end

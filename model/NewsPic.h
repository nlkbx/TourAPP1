//
//  NewsPic.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsPic : NSManagedObject

@property (nonatomic, retain) NSString * ndescription;
@property (nonatomic, retain) NSNumber * nid;
@property (nonatomic, retain) NSString * npicpath;

@end

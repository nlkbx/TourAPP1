//
//  SystemUpdate.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SystemUpdate : NSManagedObject

@property (nonatomic, retain) NSNumber * sid;
@property (nonatomic, retain) NSString * tableName;
@property (nonatomic, retain) NSDate * update;

@end

//
//  Pro_Country.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City;

@interface Pro_Country : NSManagedObject

@property (nonatomic, retain) NSDate * createdate;
@property (nonatomic, retain) NSNumber * ischina;
@property (nonatomic, retain) NSNumber * pid;
@property (nonatomic, retain) NSString * pname;
@property (nonatomic, retain) NSDate * updatedate;
@property (nonatomic, retain) NSSet *pro_city;
@end

@interface Pro_Country (CoreDataGeneratedAccessors)

- (void)addPro_cityObject:(City *)value;
- (void)removePro_cityObject:(City *)value;
- (void)addPro_city:(NSSet *)values;
- (void)removePro_city:(NSSet *)values;

@end

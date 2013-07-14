//
//  Scenic.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Equipment, ScenicPic, ScenicType;

@interface Scenic : NSManagedObject

@property (nonatomic, retain) NSNumber * cid;
@property (nonatomic, retain) NSString * saddress;
@property (nonatomic, retain) NSNumber * sadultticket;
@property (nonatomic, retain) NSNumber * schildrenticket;
@property (nonatomic, retain) NSString * scontactnumber;
@property (nonatomic, retain) NSString * sdesciotion;
@property (nonatomic, retain) NSNumber * sid;
@property (nonatomic, retain) NSNumber * slatitude;
@property (nonatomic, retain) NSNumber * slongitude;
@property (nonatomic, retain) NSString * sname;
@property (nonatomic, retain) NSNumber * supdatedate;
@property (nonatomic, retain) NSString * surl;
@property (nonatomic, retain) City *scenic_city;
@property (nonatomic, retain) NSSet *scenic_equipment;
@property (nonatomic, retain) NSSet *scenic_scenicpic;
@property (nonatomic, retain) NSSet *scenic_type;
@end

@interface Scenic (CoreDataGeneratedAccessors)

- (void)addScenic_equipmentObject:(Equipment *)value;
- (void)removeScenic_equipmentObject:(Equipment *)value;
- (void)addScenic_equipment:(NSSet *)values;
- (void)removeScenic_equipment:(NSSet *)values;

- (void)addScenic_scenicpicObject:(ScenicPic *)value;
- (void)removeScenic_scenicpicObject:(ScenicPic *)value;
- (void)addScenic_scenicpic:(NSSet *)values;
- (void)removeScenic_scenicpic:(NSSet *)values;

- (void)addScenic_typeObject:(ScenicType *)value;
- (void)removeScenic_typeObject:(ScenicType *)value;
- (void)addScenic_type:(NSSet *)values;
- (void)removeScenic_type:(NSSet *)values;

@end

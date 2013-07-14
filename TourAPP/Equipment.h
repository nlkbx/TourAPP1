//
//  Equipment.h
//  TourAPP
//
//  Created by 徐彪 on 13-7-7.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Equipment, Scenic;

@interface Equipment : NSManagedObject

@property (nonatomic, retain) NSDate * createdate;
@property (nonatomic, retain) NSNumber * eid;
@property (nonatomic, retain) NSString * ename;
@property (nonatomic, retain) NSDate * updatedate;
@property (nonatomic, retain) NSString * cid;
@property (nonatomic, retain) Equipment *eqiupments_equipment;
@property (nonatomic, retain) NSSet *equipment_equipments;
@property (nonatomic, retain) NSSet *scenic_equipment;
@end

@interface Equipment (CoreDataGeneratedAccessors)

- (void)addEquipment_equipmentsObject:(Equipment *)value;
- (void)removeEquipment_equipmentsObject:(Equipment *)value;
- (void)addEquipment_equipments:(NSSet *)values;
- (void)removeEquipment_equipments:(NSSet *)values;

- (void)addScenic_equipmentObject:(Scenic *)value;
- (void)removeScenic_equipmentObject:(Scenic *)value;
- (void)addScenic_equipment:(NSSet *)values;
- (void)removeScenic_equipment:(NSSet *)values;

@end

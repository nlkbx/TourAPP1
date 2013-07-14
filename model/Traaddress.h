//
//  Traaddress.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Travelagency;

@interface Traaddress : NSManagedObject

@property (nonatomic, retain) NSNumber * cid;
@property (nonatomic, retain) NSString * taddress;
@property (nonatomic, retain) NSNumber * tid;
@property (nonatomic, retain) NSNumber * tlatitude;
@property (nonatomic, retain) NSNumber * tlongitude;
@property (nonatomic, retain) NSString * tnumber;
@property (nonatomic, retain) NSNumber * ttid;
@property (nonatomic, retain) NSSet *city_tra;
@property (nonatomic, retain) Travelagency *travelagency_address;
@end

@interface Traaddress (CoreDataGeneratedAccessors)

- (void)addCity_traObject:(City *)value;
- (void)removeCity_traObject:(City *)value;
- (void)addCity_tra:(NSSet *)values;
- (void)removeCity_tra:(NSSet *)values;

@end

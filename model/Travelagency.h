//
//  Travelagency.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Traaddress;

@interface Travelagency : NSManagedObject

@property (nonatomic, retain) NSString * tdescription;
@property (nonatomic, retain) NSNumber * tid;
@property (nonatomic, retain) NSString * tname;
@property (nonatomic, retain) NSString * turl;
@property (nonatomic, retain) NSSet *travelagency_address;
@end

@interface Travelagency (CoreDataGeneratedAccessors)

- (void)addTravelagency_addressObject:(Traaddress *)value;
- (void)removeTravelagency_addressObject:(Traaddress *)value;
- (void)addTravelagency_address:(NSSet *)values;
- (void)removeTravelagency_address:(NSSet *)values;

@end

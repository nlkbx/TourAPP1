//
//  Restaurant.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, FoodType, RestaurantPic, Specialfood;

@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSNumber * cid;
@property (nonatomic, retain) NSString * raddress;
@property (nonatomic, retain) NSNumber * raveprice;
@property (nonatomic, retain) NSString * rcontactnumber;
@property (nonatomic, retain) NSString * rdescription;
@property (nonatomic, retain) NSNumber * rid;
@property (nonatomic, retain) NSNumber * rlatitude;
@property (nonatomic, retain) NSNumber * rlongitude;
@property (nonatomic, retain) NSString * rname;
@property (nonatomic, retain) NSNumber * rupdatedate;
@property (nonatomic, retain) NSString * rurl;
@property (nonatomic, retain) NSSet *restaurant_food;
@property (nonatomic, retain) NSSet *restaurant_pic;
@property (nonatomic, retain) City *restautant_city;
@property (nonatomic, retain) NSSet *restautant_type;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addRestaurant_foodObject:(Specialfood *)value;
- (void)removeRestaurant_foodObject:(Specialfood *)value;
- (void)addRestaurant_food:(NSSet *)values;
- (void)removeRestaurant_food:(NSSet *)values;

- (void)addRestaurant_picObject:(RestaurantPic *)value;
- (void)removeRestaurant_picObject:(RestaurantPic *)value;
- (void)addRestaurant_pic:(NSSet *)values;
- (void)removeRestaurant_pic:(NSSet *)values;

- (void)addRestautant_typeObject:(FoodType *)value;
- (void)removeRestautant_typeObject:(FoodType *)value;
- (void)addRestautant_type:(NSSet *)values;
- (void)removeRestautant_type:(NSSet *)values;

@end

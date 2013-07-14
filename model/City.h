//
//  City.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CityPic, Hotel, News, Restaurant, Scenic, Traaddress;

@interface City : NSManagedObject

@property (nonatomic, retain) NSString * cdescription;
@property (nonatomic, retain) NSNumber * cid;
@property (nonatomic, retain) NSNumber * cistourcity;
@property (nonatomic, retain) NSNumber * clatitude;
@property (nonatomic, retain) NSNumber * clongitude;
@property (nonatomic, retain) NSString * cname;
@property (nonatomic, retain) NSString * cpingying;
@property (nonatomic, retain) NSString * csuoxie;
@property (nonatomic, retain) NSNumber * cupdatedate;
@property (nonatomic, retain) NSNumber * pid;
@property (nonatomic, retain) NSSet *city_hotel;
@property (nonatomic, retain) NSSet *city_news;
@property (nonatomic, retain) NSSet *city_pic;
@property (nonatomic, retain) NSSet *city_restautrant;
@property (nonatomic, retain) NSSet *city_scenic;
@property (nonatomic, retain) NSSet *city_tra;
@end

@interface City (CoreDataGeneratedAccessors)

- (void)addCity_hotelObject:(Hotel *)value;
- (void)removeCity_hotelObject:(Hotel *)value;
- (void)addCity_hotel:(NSSet *)values;
- (void)removeCity_hotel:(NSSet *)values;

- (void)addCity_newsObject:(News *)value;
- (void)removeCity_newsObject:(News *)value;
- (void)addCity_news:(NSSet *)values;
- (void)removeCity_news:(NSSet *)values;

- (void)addCity_picObject:(CityPic *)value;
- (void)removeCity_picObject:(CityPic *)value;
- (void)addCity_pic:(NSSet *)values;
- (void)removeCity_pic:(NSSet *)values;

- (void)addCity_restautrantObject:(Restaurant *)value;
- (void)removeCity_restautrantObject:(Restaurant *)value;
- (void)addCity_restautrant:(NSSet *)values;
- (void)removeCity_restautrant:(NSSet *)values;

- (void)addCity_scenicObject:(Scenic *)value;
- (void)removeCity_scenicObject:(Scenic *)value;
- (void)addCity_scenic:(NSSet *)values;
- (void)removeCity_scenic:(NSSet *)values;

- (void)addCity_traObject:(Traaddress *)value;
- (void)removeCity_traObject:(Traaddress *)value;
- (void)addCity_tra:(NSSet *)values;
- (void)removeCity_tra:(NSSet *)values;

@end

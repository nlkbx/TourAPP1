//
//  Hotel.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, HotelPic;

@interface Hotel : NSManagedObject

@property (nonatomic, retain) NSNumber * cid;
@property (nonatomic, retain) NSString * hcontactnumber;
@property (nonatomic, retain) NSString * hdescription;
@property (nonatomic, retain) NSNumber * hid;
@property (nonatomic, retain) NSNumber * hlatitude;
@property (nonatomic, retain) NSNumber * hlongitude;
@property (nonatomic, retain) NSNumber * hmaxprice;
@property (nonatomic, retain) NSNumber * hminprice;
@property (nonatomic, retain) NSString * hname;
@property (nonatomic, retain) NSString * hraddress;
@property (nonatomic, retain) NSNumber * hroonnumber;
@property (nonatomic, retain) NSNumber * hstar;
@property (nonatomic, retain) NSNumber * hupdatedate;
@property (nonatomic, retain) NSString * hurl;
@property (nonatomic, retain) City *hotel_city;
@property (nonatomic, retain) NSSet *hotel_pic;
@end

@interface Hotel (CoreDataGeneratedAccessors)

- (void)addHotel_picObject:(HotelPic *)value;
- (void)removeHotel_picObject:(HotelPic *)value;
- (void)addHotel_pic:(NSSet *)values;
- (void)removeHotel_pic:(NSSet *)values;

@end

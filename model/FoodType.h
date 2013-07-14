//
//  FoodType.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;

@interface FoodType : NSManagedObject

@property (nonatomic, retain) NSDate * createdate;
@property (nonatomic, retain) NSNumber * fid;
@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSDate * updatedate;
@property (nonatomic, retain) NSSet *restautant_type;
@end

@interface FoodType (CoreDataGeneratedAccessors)

- (void)addRestautant_typeObject:(Restaurant *)value;
- (void)removeRestautant_typeObject:(Restaurant *)value;
- (void)addRestautant_type:(NSSet *)values;
- (void)removeRestautant_type:(NSSet *)values;

@end

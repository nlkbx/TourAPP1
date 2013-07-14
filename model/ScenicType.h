//
//  ScenicType.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Scenic;

@interface ScenicType : NSManagedObject

@property (nonatomic, retain) NSNumber * sid;
@property (nonatomic, retain) NSString * stype;
@property (nonatomic, retain) NSDate * createdate;
@property (nonatomic, retain) NSDate * updatedate;
@property (nonatomic, retain) NSSet *typr_scenic;
@end

@interface ScenicType (CoreDataGeneratedAccessors)

- (void)addTypr_scenicObject:(Scenic *)value;
- (void)removeTypr_scenicObject:(Scenic *)value;
- (void)addTypr_scenic:(NSSet *)values;
- (void)removeTypr_scenic:(NSSet *)values;

@end

//
//  News.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NewsPic;

@interface News : NSManagedObject

@property (nonatomic, retain) NSNumber * cid;
@property (nonatomic, retain) NSString * ncontent;
@property (nonatomic, retain) NSDate * ncreatedate;
@property (nonatomic, retain) NSDate * nexpirydate;
@property (nonatomic, retain) NSNumber * nid;
@property (nonatomic, retain) NSSet *news_newspic;
@end

@interface News (CoreDataGeneratedAccessors)

- (void)addNews_newspicObject:(NewsPic *)value;
- (void)removeNews_newspicObject:(NewsPic *)value;
- (void)addNews_newspic:(NSSet *)values;
- (void)removeNews_newspic:(NSSet *)values;

@end

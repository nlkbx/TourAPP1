//
//  MyHttpRequest.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-14.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MyHttpRequestDelegate <NSObject>
@optional
- (void) didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict tag:(NSInteger)tag userInfo:(id)userinfo;
- (void)didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName tag:(NSInteger)tag userInfo:(id)userinfo;
- (void)foundCharacters:(NSString *)string tag:(NSInteger)tag userInfo:(id)userinfo;
@end
@interface MyHttpRequest : NSObject<NSXMLParserDelegate>
@property(nonatomic,assign)id<MyHttpRequestDelegate> delegate;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,retain)id userInfo;
-(id)initWithDelegate:(id<MyHttpRequestDelegate>) _delegate tag:(NSInteger) _tag userInfo:(id)userinfo;
-(void)sendRequestToURL:(NSString*)url;
-(void)sendRequestToURL:(NSString *)url params:(NSString*)params;
@end

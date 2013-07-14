//
//  MyHttpRequest.m
//  TourAPP
//
//  Created by 徐彪 on 13-6-14.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "MyHttpRequest.h"
#import "AFXMLRequestOperation.h"
@implementation MyHttpRequest
@synthesize delegate,tag,userInfo;
-(id)initWithDelegate:(id<MyHttpRequestDelegate>) _delegate tag:(NSInteger) _tag userInfo:(id)userinfo{
    if(self=[super init]){
        self.delegate=_delegate;
        self.tag=_tag;
        self.userInfo=userinfo;
        return self;
    }
    return nil;
}
-(void)sendRequestToURL:(NSString*)url{
    [self sendRequestToURL:url params:nil];
}
-(void)sendRequestToURL:(NSString *)url params:(NSString*)params{
    NSURL *URL=[[NSURL alloc]initWithString:url];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:URL];
    [request setHTTPMethod:@"POST"];
    if(params!=nil)
    {
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    }
    AFXMLRequestOperation *xml=[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        XMLParser.delegate=self;
        [XMLParser parse];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
        NSLog(@"错误：%@",error);
    }];
    [xml start];

}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([delegate respondsToSelector:@selector(didStartElement:namespaceURI:qualifiedName:attributes:tag:userInfo:)])
    [delegate didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict tag:tag userInfo:userInfo];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([delegate respondsToSelector:@selector(didEndElement:namespaceURI:qualifiedName:tag:userInfo:)])
    [delegate didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName tag:tag userInfo:userInfo];
}
// sent when an end tag is encountered. The various parameters are supplied as above.

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if([delegate respondsToSelector:@selector(foundCharacters:tag:userInfo:)])
    [delegate foundCharacters:string tag:tag userInfo:userInfo];
}
@end

//
//  ApiRequest.h
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import <Mantle/Mantle.h>

@protocol AFURLResponseSerialization;

extern NSString * const ApiRequestMethodGET;
extern NSString * const ApiRequestMethodPOST;

@interface ApiRequest : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *method;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, readonly) NSDictionary *parameters;

@property (nonatomic, copy) id<AFURLResponseSerialization> responseSerializer;

@property (nonatomic, copy) void (^successBlock)(id responseObject);
@property (nonatomic, copy) void (^errorBlock)(NSError *error);

@end

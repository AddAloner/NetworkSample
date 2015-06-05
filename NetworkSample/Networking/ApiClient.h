//
//  ApiClient.h
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import <AFNetworking.h>
#import "ApiClientConfiguration.h"
#import "ApiRequest.h"

@class MediaListResponse;

@interface ApiClient : AFHTTPRequestOperationManager

- (instancetype)initWithConfiguration:(ApiClientConfiguration *)configuration;

- (AFHTTPRequestOperation *)send:(ApiRequest *)request;

@end

/**
 * отдельные группы запросов выносятся в категории, если их большое колличество - разносятся по классам
 */
@interface ApiClient (Users)

- (AFHTTPRequestOperation *)getUserMedia:(NSString *)userId success:(void (^)(MediaListResponse *responseObject))successBlock error:(void (^)(NSError *error))errorBlock;

@end

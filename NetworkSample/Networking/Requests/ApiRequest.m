//
//  ApiRequest.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "ApiRequest.h"

NSString * const ApiRequestMethodGET = @"GET";
NSString * const ApiRequestMethodPOST = @"POST";

@implementation ApiRequest

#pragma mark - Initialization

- (instancetype)init
{
    if (self = [super init]) {
        self.method = ApiRequestMethodGET;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

#pragma mark - Parameters Configuration

- (NSDictionary *)parameters
{
    NSError *error;
    NSDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self error:&error];
    
    NSMutableArray *nullKeys = [NSMutableArray new];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSNull class]])
            [nullKeys addObject:key];
    }];
    
    if (nullKeys.count > 0) {
        dictionary = [dictionary mtl_dictionaryByRemovingValuesForKeys:nullKeys];
    }
    NSAssert(error == nil, @"%@", error);
    return dictionary;
}

@end

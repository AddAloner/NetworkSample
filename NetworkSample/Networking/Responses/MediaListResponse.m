//
//  MediaListResponse.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "MediaListResponse.h"
#import "UserMedia.h"
#import "Util.h"

@implementation MediaListResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{SelString(data) : @"data"
             };
}

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[UserMedia class]];
}

@end

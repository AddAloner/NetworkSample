//
//  UserMedia.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "UserMedia.h"
#import "Util.h"
#import "NSValueTransformer+PredefinedTransformers.h"

@implementation UserMedia

#pragma mark - Mapping

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{SelString(tags): @"tags",
             SelString(filter): @"filter",
             SelString(link): @"link",
             SelString(createdTime): @"created_time",
             SelString(images): @"images",
             };
}

+ (NSValueTransformer *)createdTimeJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:ALODateTimeValueTransformerName];
}

+ (NSValueTransformer *)linkJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end

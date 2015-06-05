//
//  UserMediaRequest.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "UserMediaRequest.h"
#import "ResponseSerializer.h"
#import "MediaListResponse.h"
#import "Util.h"

@implementation UserMediaRequest

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.responseSerializer = [[ResponseSerializer alloc] initWithModelClass:[MediaListResponse class]];
    }
    return self;
}

#pragma mark - Mapping

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

- (NSString *)path
{
    NSString *path = @"users/%@/media/recent";
    return [NSString stringWithFormat:path, self.userId];
}

@end

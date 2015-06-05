//
//  ApiClientConfiguration.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "ApiClientConfiguration.h"

@implementation ApiClientConfiguration

+ (instancetype)testConfiguration
{
    ApiClientConfiguration *configuration = [ApiClientConfiguration new];
    configuration.baseURL = [NSURL URLWithString:@"https://api.instagram.com/v1/"];
    configuration.authenticationKey = @"07d96924714c49729f310a7f01b3815f";
    return configuration;
}


@end

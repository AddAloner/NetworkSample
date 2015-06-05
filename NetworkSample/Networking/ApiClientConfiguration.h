//
//  ApiClientConfiguration.h
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiClientConfiguration : NSObject

@property (nonatomic, copy) NSString *authenticationKey;
@property (nonatomic, strong) NSURL *baseURL;

+ (instancetype)testConfiguration;

@end

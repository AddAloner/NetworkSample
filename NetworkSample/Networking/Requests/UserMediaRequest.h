//
//  UserMediaRequest.h
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "ApiRequest.h"

@interface UserMediaRequest : ApiRequest

@property (nonatomic, copy) NSString *userId;

@end

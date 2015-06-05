//
//  MediaListResponse.h
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "ApiResponse.h"

@interface MediaListResponse : ApiResponse

@property (nonatomic, copy) NSArray *data;

@end

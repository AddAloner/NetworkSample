//
//  UserMedia.h
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import <Mantle.h>

@interface UserMedia : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy) NSString *filter;
@property (nonatomic, copy) NSURL *link;
@property (nonatomic, strong) NSDate *createdTime;
// TODO: на реальном проекте images нужно привести к нормальному объекту
@property (nonatomic, copy) NSDictionary *images;

@end

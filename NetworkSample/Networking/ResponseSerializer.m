//
//  ResponseSerializer.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "ResponseSerializer.h"
#import "ApiResponse.h"
#import "Util.h"

NSString * const SPSAPIResponseSerializationErrorDomain = @"ApiResponseSerializationErrorDomain";
NSString * const SPSAPIResponseSerializationErrorResponseKey = @"ApiResponseSerializationErrorResponseKey";

@implementation ResponseSerializer

#pragma mark - Initialization

- (instancetype)initWithModelClass:(Class)modelClass
{
    if (self = [self init]) {
        self.modelClass = modelClass;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.acceptableContentTypes = nil;
        self.acceptableStatusCodes = nil;
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    typeof(self) copy = [super copyWithZone:zone];
    copy.modelClass = self.modelClass;
    return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        self.modelClass = NSClassFromString([decoder decodeObjectOfClass:[NSString class] forKey:SelString(modelClass)]);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeObject:NSStringFromClass(self.modelClass) forKey:SelString(modelClass)];
}

#pragma mark - Response Serialization

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    // response validation
    [self validateResponse:(NSHTTPURLResponse *)response data:data error:error];
    if (*error != nil) {
        return nil;
    }
    
    // serialize json response
    AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer new];
    jsonResponseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    jsonResponseSerializer.acceptableStatusCodes = self.acceptableStatusCodes;
    jsonResponseSerializer.stringEncoding = self.stringEncoding;
    id responseObject = [jsonResponseSerializer responseObjectForResponse:response data:data error:error];
    
    if (*error) {
        return nil;
    }
    
    // try to obtain mapped object form the JSON response
    id responseModel;
    @try {
        responseModel = [MTLJSONAdapter modelOfClass:self.modelClass fromJSONDictionary:responseObject error:error];
    }
    @catch (NSException *exception) {
        if (*error) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [exception description]};
            *error = [NSError errorWithDomain:SPSAPIResponseSerializationErrorDomain code:ApiResponseSerializerMappingError userInfo:userInfo];
        }
    }
    
    return responseModel;
}

@end

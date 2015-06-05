//
//  ApiClient.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "ApiClient.h"
#import "MediaListResponse.h"
#import "UserMediaRequest.h"

static NSString * authentificationKey = @"client_id";

@interface ApiClient ()

// в этом месте можно использовать объект, содержащий информацию для аутентификации,но в силу того что проект делался как пример - в этом месте я упростил логику
@property (nonatomic, copy) NSString *authenticationKey;

@end

@implementation ApiClient

#pragma mark - Initialization

- (instancetype)initWithConfiguration:(ApiClientConfiguration *)configuration
{
    if (self = [super initWithBaseURL:configuration.baseURL]) {
        self.authenticationKey = configuration.authenticationKey;
        self.responseSerializer = [AFHTTPResponseSerializer new]; // Passthrough Response Serializer
    }
    return self;

}

#pragma mark - Requests

- (AFHTTPRequestOperation *)send:(ApiRequest *)request
{
    void(^successOnMainQueue)(id) = ^void(id responseObject_) {
        if (request.successBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                request.successBlock(responseObject_);
            });
        }
    };
    
    void(^errorOnMainQueue)(NSError *) = ^void(NSError *error) {
        if (request.errorBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                request.errorBlock(error);
            });
        }
    };
    
    __weak typeof(self) weakSelf = self;
    
    NSError *error;
    NSURLRequest *urlRequest = [self urlRequestWithRequest:request error:&error];
    if (error) {
        errorOnMainQueue(error);
    }
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf serializeResponse:operation.response data:responseObject responseSerializer:request.responseSerializer success:^(id responseObject_) {
            successOnMainQueue(responseObject_);
        } error:^(NSError *error) {
            errorOnMainQueue(error);
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorOnMainQueue(error);
    }];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}


#pragma mark Response Serialization

- (NSURLRequest *)urlRequestWithRequest:(ApiRequest *)request error:(NSError *__autoreleasing *)error
{
    NSDictionary *parameters = [self addAuthInformationInRequestParameters:request.parameters];
    NSString *urlString = [NSURL URLWithString:request.path relativeToURL:self.baseURL].absoluteString;
    
    NSMutableURLRequest *urlRequest = [self.requestSerializer requestWithMethod:request.method URLString:urlString parameters:parameters error:error];
    
    return urlRequest;
}

- (NSDictionary *)addAuthInformationInRequestParameters:(NSDictionary *)parameters
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setValue:self.authenticationKey forKey:authentificationKey];
    return [mutableParameters copy];
}

- (void)serializeResponse:(NSURLResponse *)response data:(NSData *)data responseSerializer:(id<AFURLResponseSerialization>)responseSerializer success:(void (^)(id responseObject))successBlock error:(void (^)(NSError *error))errorBlock
{
    NSError *error;
    id responseResult = [responseSerializer responseObjectForResponse:response data:data error:&error];
    
    if (error) {
        if (errorBlock) {
            errorBlock(error);
        }
    } else {
        if (successBlock) {
            successBlock(responseResult);
        }
    };
};

@end

@implementation ApiClient (Users)

- (AFHTTPRequestOperation *)getUserMedia:(NSString *)userId success:(void (^)(MediaListResponse *responseObject))successBlock error:(void (^)(NSError *error))errorBlock
{
    UserMediaRequest *request = [UserMediaRequest new];
    request.userId = userId;
    
    request.successBlock = successBlock;
    request.errorBlock = errorBlock;
    
    return [self send:request];
}

@end

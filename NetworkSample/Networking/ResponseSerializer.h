//
//  ResponseSerializer.h
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "AFURLResponseSerialization.h"

extern NSString * const ApiResponseSerializationErrorDomain;
extern NSString * const ApiResponseSerializationErrorResponseKey;

typedef NS_ENUM(NSInteger, ApiResponseSerializerErrorCode) {
    ApiResponseSerializerMappingError, // ошибка сериализации данных
    ApiResponseSerializerInvalidResponseResult // ошибка в статусе ответа
};

@interface ResponseSerializer : AFHTTPResponseSerializer

@property (nonatomic, strong) Class modelClass;

- (instancetype)initWithModelClass:(Class)modelClass;

@end

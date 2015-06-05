//
//  NSValueTransformer+PredefinedTransformers.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "NSValueTransformer+PredefinedTransformers.h"
#import <Mantle.h>

NSString * const ALODateTimeValueTransformerName = @"ALODateTimeValueTransformerName";

@implementation NSValueTransformer (PredefinedTransformers)

+ (void)load
{
    @autoreleasepool {
        // date time
        MTLValueTransformer *dateTimeValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^ id (NSString *str, BOOL *success, NSError **error) {
            if (str == nil) return nil;
            
            if (![str isKindOfClass:NSString.class]) {
                if (error != NULL) {
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Could not convert string to date", @""),
                                               NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"Expected an NSString, got: %@.", @""), str],
                                               MTLTransformerErrorHandlingInputValueErrorKey : str};
                    
                    *error = [NSError errorWithDomain:MTLTransformerErrorHandlingErrorDomain code:MTLTransformerErrorHandlingErrorInvalidInput userInfo:userInfo];
                }
                *success = NO;
                return nil;
            }
            
            NSDate *result = [NSDate dateWithTimeIntervalSince1970:str.integerValue];
            
            if (result == nil) {
                if (error != NULL) {
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Could not convert string to date", @""),
                                               NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"Input date string %@ was malformed", @""), str],
                                               MTLTransformerErrorHandlingInputValueErrorKey : str};
                    
                    *error = [NSError errorWithDomain:MTLTransformerErrorHandlingErrorDomain code:MTLTransformerErrorHandlingErrorInvalidInput userInfo:userInfo];
                }
                *success = NO;
                return nil;
            }
            
            return result;
        } reverseBlock:^ id (NSDate *date, BOOL *success, NSError **error) {
            if (date == nil) return nil;
            
            if (![date isKindOfClass:NSDate.class]) {
                if (error != NULL) {
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Could not convert Date to string", @""),
                                               NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"Expected an NSDate, got: %@.", @""), date],
                                               MTLTransformerErrorHandlingInputValueErrorKey : date};
                    
                    *error = [NSError errorWithDomain:MTLTransformerErrorHandlingErrorDomain code:MTLTransformerErrorHandlingErrorInvalidInput userInfo:userInfo];
                }
                *success = NO;
                return nil;
            }
            
            return @(date.timeIntervalSince1970);
        }];
        [NSValueTransformer setValueTransformer:dateTimeValueTransformer forName:ALODateTimeValueTransformerName];
    }
}

@end

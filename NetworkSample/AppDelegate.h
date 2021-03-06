//
//  AppDelegate.h
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiClient.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) ApiClient *apiClient;

@end


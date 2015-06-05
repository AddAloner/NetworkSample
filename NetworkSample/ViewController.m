//
//  ViewController.m
//  NetworkSample
//
//  Created by Alexey Yachmenov on 05.06.15.
//  Copyright (c) 2015 Alexey Yachmenov. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MediaListResponse.h"

static NSString * const testUserId = @"7013409";

@interface ViewController ()

@property (nonatomic, copy) NSArray *items;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [[appDelegate.apiClient getUserMedia:testUserId success:^(MediaListResponse *responseObject) {
        self.items = responseObject.data;
        // TODO: reload interface
    } error:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }] resume];
}

@end

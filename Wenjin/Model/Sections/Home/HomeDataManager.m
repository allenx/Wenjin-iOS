//
//  HomeDataManager.m
//  Wenjin
//
//  Created by 秦昱博 on 15/3/29.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

#import "HomeDataManager.h"
#import "wjAPIs.h"
#import "wjCacheManager.h"
#import "AFNetworking.h"
#import "JSONKit.h"

@implementation HomeDataManager

+ (void)getHomeDataWithPage:(NSInteger)page success:(void (^)(NSArray *, BOOL))success failure:(void (^)(NSString *))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSDictionary *parameters = @{@"page": [NSNumber numberWithInteger:page],
                                 @"per_page": @20};
    if (page == 0) {
        [wjCacheManager loadCacheDataWithKey:@"homeCache" andBlock:^(NSArray *rows) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(rows, NO);
            });
        }];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[wjAPIs homeURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = [operation.responseString objectFromJSONString];
        if ([responseDic[@"errno"] isEqual: @1]) {
            NSArray *rows = (responseDic[@"rsm"])[@"rows"];
            if (page == 0) {
                [wjCacheManager saveCacheData:rows withKey:@"homeCache"];
            }
            if ([(responseDic[@"rsm"])[@"total_rows"] isEqual: @0]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(rows, YES);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(rows, NO);
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(responseDic[@"err"]);
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(error.localizedDescription);
        });
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

@end

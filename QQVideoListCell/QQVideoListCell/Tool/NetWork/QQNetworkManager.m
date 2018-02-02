//
//  QQNetworkManager.m
//  adsasd
//
//  Created by Mac on 2017/11/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQNetworkManager.h"

#define QQ_NET_BASE_URL                     @"http://c.m.163.com/"

@implementation QQNetworkManager

+ (instancetype)sharedManager {
    
    static QQNetworkManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:QQ_NET_BASE_URL];
        manager = [[self alloc] initWithBaseURL:baseURL];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        
    });
    return manager;
}

- (void)qq_request:(QQRequestMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id result, NSError *error))finished {
    
    if (method == GET) {
        
        [self GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"downloadProgress = %@", downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil, error);
        }];
        
    } else {
        
        [self POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"downloadProgress = %@", downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil, error);
        }];
    }
}

@end

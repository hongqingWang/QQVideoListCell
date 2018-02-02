//
//  QQNetworkManager.h
//  adsasd
//
//  Created by Mac on 2017/11/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum : NSUInteger {
    GET,
    POST
} QQRequestMethod;

@interface QQNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)qq_request:(QQRequestMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id result, NSError *error))finished;

@end

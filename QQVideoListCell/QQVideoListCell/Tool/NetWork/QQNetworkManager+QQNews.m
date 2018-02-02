//
//  QQNetworkManager+QQNews.m
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNetworkManager+QQNews.h"

static NSString *const newsURLString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";
static NSString *const newsVideoURLString = @"http://c.m.163.com/nc/video/home/0-10.html";

@implementation QQNetworkManager (QQNews)

- (void)loadNewsDataCompletion:(void (^)(NSArray *))completion {
    
    [[QQNetworkManager sharedManager] qq_request:GET urlString:newsVideoURLString parameters:nil finished:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%s %@", __FUNCTION__, error);
        }
        NSLog(@"%s %@", __FUNCTION__, result);
        
        /**
         * 简单处理数据,只把需要的回调到`QQNewsListViewModel`中
         */
        completion(result[@"videoList"]);
    }];
}

@end

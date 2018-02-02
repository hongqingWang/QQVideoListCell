//
//  QQNewsListViewModel.m
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsListViewModel.h"
#import "QQNewsViewModel.h"
#import "QQNetworkManager+QQNews.h"
#import <MJExtension.h>
#import "QQNews.h"

@implementation QQNewsListViewModel

- (void)loadNewsDataCompletion:(void (^)(BOOL))completion {
    
    // 调用`QQNetworkManager+QQNews`中的获取新闻数据的方法
    [[QQNetworkManager sharedManager] loadNewsDataCompletion:^(NSArray *dataArray) {
        
        NSLog(@"%s %@", __FUNCTION__, dataArray);
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dataArray.count];
        
        for (NSDictionary *dict in dataArray) {
            
            QQNews *news = [QQNews mj_objectWithKeyValues:dict];
            [arrayM addObject:[QQNewsViewModel viewModelWithNews:news]];
        }
        
        [self.newsList addObjectsFromArray:arrayM];
        
        // 将结果回调给`QQNewsViewController`,使其进行刷新界面等操作
        completion(YES);
    }];
}

#pragma mark - Getters and Setters
- (NSMutableArray *)newsList {
    if (_newsList == nil) {
        _newsList = [[NSMutableArray alloc] init];
    }
    return _newsList;
}

@end

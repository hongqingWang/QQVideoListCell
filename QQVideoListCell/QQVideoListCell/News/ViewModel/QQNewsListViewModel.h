//
//  QQNewsListViewModel.h
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QQNewsViewModel;

@interface QQNewsListViewModel : NSObject

/// 新闻`视图模型`数组
@property (nonatomic, strong) NSMutableArray *newsList;

/**
 加载新闻数据

 @param completion completion
 */
- (void)loadNewsDataCompletion:(void (^)(BOOL isSuccessed))completion;

@end

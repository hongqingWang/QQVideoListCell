//
//  QQNewsViewModel.h
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQNews;

@interface QQNewsViewModel : NSObject

/// 新闻数据模型
@property (nonatomic, strong) QQNews *news;
/// 标题
@property (nonatomic, copy) NSString *title_string;
/// 新闻图片
@property (nonatomic, strong) NSURL *image_url;
/// 新闻图片
@property (nonatomic, copy) NSString *image_url_string;
/// mp4_url
@property (nonatomic, strong) NSURL *mp4_url;
/// 跟帖数(在此处理)
@property (nonatomic, copy) NSString *replyCount_string;
/// CellHeight
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)viewModelWithNews:(QQNews *)news;

@end

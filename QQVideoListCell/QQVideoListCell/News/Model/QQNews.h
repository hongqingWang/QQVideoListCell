//
//  QQNews.h
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQNews : NSObject

/// 标题
@property (nonatomic, copy) NSString *title;
/// 视频封面
@property (nonatomic, copy) NSString *cover;
/// mp4_url
@property (nonatomic, copy) NSString *mp4_url;
/// 跟帖数
@property (nonatomic, assign) NSInteger replyCount;

@end

//
//  QQNewsViewModel.m
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsViewModel.h"
#import "QQNews.h"

static CGFloat const margin = 16;

@implementation QQNewsViewModel

+ (instancetype)viewModelWithNews:(QQNews *)news {
    
    QQNewsViewModel *viewModel = [[self alloc] init];
    
    viewModel.news = news;
    
    return viewModel;
}

- (NSString *)title_string {
    return self.news.title;
}

- (NSURL *)image_url {
    return [NSURL URLWithString:self.news.cover];
}

- (NSString *)image_url_string {
    return self.news.cover;
}

- (NSURL *)mp4_url {
    return [NSURL URLWithString:self.news.mp4_url];
}

- (NSString *)replyCount_string {
    
    // 测试跟帖数超过1万
//    self.news.replyCount = 23456;
    
    if (self.news.replyCount >= 10000) {
        
        NSString *string = [NSString stringWithFormat:@"%ld万 跟帖", self.news.replyCount / 10000];
        return string;
    }
    return [NSString stringWithFormat:@"%ld 跟帖", self.news.replyCount];
}

- (CGFloat)cellHeight {
    
    if (_cellHeight) {
        return _cellHeight;
    }

    CGSize textMaxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - (2 * margin), MAXFLOAT);

    _cellHeight += 10;
    _cellHeight += [self.news.title boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += 10;
    // 视频封面的高度
    _cellHeight += 180;
    _cellHeight += 10;
    _cellHeight += 16;
//    _cellHeight += [self.news.source boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Regular" size:11]} context:nil].size.height;
    _cellHeight += 10;

    return _cellHeight;
}

@end

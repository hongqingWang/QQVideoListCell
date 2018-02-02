//
//  QQNewsVideoCell.h
//  QQScrollView
//
//  Created by Mac on 05/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQNewsViewModel;

@interface QQNewsVideoCell : UITableViewCell

/// NewsViewModel
@property (nonatomic, strong) QQNewsViewModel *viewModel;
/// 图片
@property (nonatomic, strong) UIImageView *newsImageView;
/// 播放按钮
@property (nonatomic, strong) UIButton *playButton;
/** 播放按钮block */
@property (nonatomic, copy  ) void(^playBlock)(UIButton *);

+ (instancetype)qq_newsVideoCellWithTableView:(UITableView *)tableView;

@end

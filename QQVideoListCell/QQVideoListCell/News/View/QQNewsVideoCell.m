//
//  QQNewsVideoCell.m
//  QQScrollView
//
//  Created by Mac on 05/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsVideoCell.h"
#import "QQNewsViewModel.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface QQNewsVideoCell ()


/// 标题
@property (nonatomic, strong) UILabel *newsTitleLabel;
/// 标签
@property (nonatomic, strong) UIImageView *markImageView;
/// 来源
@property (nonatomic, strong) UILabel *sourceLabel;
/// 时间
@property (nonatomic, strong) UILabel *timeLabel;
/// 浏览量 Icon
@property (nonatomic, strong) UIImageView *newsSeeImageView;
/// 浏览量
@property (nonatomic, strong) UILabel *newsSeeLabel;

@end

@implementation QQNewsVideoCell

- (void)setViewModel:(QQNewsViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self.newsImageView sd_setImageWithURL:viewModel.image_url placeholderImage:[UIImage imageNamed:@"qq_news_placeholder"]];
    self.newsTitleLabel.text = viewModel.title_string;
//    self.markImageView.image = viewModel.markImage;

//    if (viewModel.markImage == nil) {
//
//        [self.sourceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.newsTitleLabel);
//            make.top.equalTo(self.newsImageView.mas_bottom).offset(10);
//        }];
//    }
//    self.sourceLabel.text = viewModel.source_string;
//    self.timeLabel.text = viewModel.createTime_string;
//    self.newsSeeImageView.image = viewModel.scanImage;
//    self.newsSeeLabel.text = viewModel.visitCount_string;
}

- (void)play:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}

+ (instancetype)qq_newsVideoCellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"QQNewsVideoCell";
    QQNewsVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QQNewsVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupUI];
        // 设置imageView的tag，在PlayerView中取（建议设置100以上）
        self.newsImageView.tag = 101;
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    
    [self.contentView addSubview:self.newsTitleLabel];
    [self.contentView addSubview:self.newsImageView];
    [self.newsImageView addSubview:self.playButton];
//    [self.contentView addSubview:self.playButton];
    [self.contentView addSubview:self.markImageView];
    [self.contentView addSubview:self.sourceLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.newsSeeImageView];
    [self.contentView addSubview:self.newsSeeLabel];
    
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
    }];
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.newsTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.newsTitleLabel);
        make.right.equalTo(self.newsTitleLabel);
        make.height.mas_equalTo(180);
    }];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.newsImageView);
        make.width.height.mas_equalTo(40);
    }];
    [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.newsImageView.mas_bottom).offset(10);
        make.left.equalTo(self.newsImageView);
    }];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.markImageView);
        make.left.equalTo(self.markImageView.mas_right).offset(12);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sourceLabel);
        make.left.equalTo(self.sourceLabel.mas_right).offset(12);
    }];
    [self.newsSeeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel);
        make.left.equalTo(self.timeLabel.mas_right).offset(12);
    }];
    [self.newsSeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.newsSeeImageView);
        make.left.equalTo(self.newsSeeImageView.mas_right).offset(6);
    }];
}

#pragma mark - Getters and Setters
- (UILabel *)newsTitleLabel {
    if (_newsTitleLabel == nil) {
        _newsTitleLabel = [[UILabel alloc] init];
        _newsTitleLabel.text = @"中国佛教协会回顾全国性讲经交流活动十年路塔塔塔塔塔啦啦啦啦。";
        _newsTitleLabel.textColor = [UIColor blackColor];
        _newsTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _newsTitleLabel.numberOfLines = 3;
    }
    return _newsTitleLabel;
}

- (UIImageView *)newsImageView {
    if (_newsImageView == nil) {
        _newsImageView = [[UIImageView alloc] init];
        _newsImageView.image = [UIImage imageNamed:@"qq_news_placeholder"];
    }
    return _newsImageView;
}

- (UIButton *)playButton {
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"qq_news_video_play"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UIImageView *)markImageView {
    if (_markImageView == nil) {
        _markImageView = [[UIImageView alloc] init];
        _markImageView.image = [UIImage imageNamed:@"qq_news_mark_top"];
    }
    return _markImageView;
}

- (UILabel *)sourceLabel {
    if (_sourceLabel == nil) {
        _sourceLabel = [[UILabel alloc] init];
        _sourceLabel.text = @"佛教凤凰网";
        _sourceLabel.textColor = [UIColor lightGrayColor];
        _sourceLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    }
    return _sourceLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"21分钟前";
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    }
    return _timeLabel;
}

- (UIImageView *)newsSeeImageView {
    if (_newsSeeImageView == nil) {
        _newsSeeImageView = [[UIImageView alloc] init];
        _newsSeeImageView.image = [UIImage imageNamed:@"qq_news_see"];
        _newsImageView.userInteractionEnabled = YES;
    }
    return _newsSeeImageView;
}

- (UILabel *)newsSeeLabel {
    if (_newsSeeLabel == nil) {
        _newsSeeLabel = [[UILabel alloc] init];
        _newsSeeLabel.text = @"1234";
        _newsSeeLabel.textColor = [UIColor lightGrayColor];
        _newsSeeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    }
    return _newsSeeLabel;
}

@end

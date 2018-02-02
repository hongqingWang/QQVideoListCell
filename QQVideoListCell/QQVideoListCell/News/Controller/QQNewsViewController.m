//
//  QQNewsViewController.m
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsViewController.h"
#import "QQNewsVideoCell.h"
#import "QQNewsListViewModel.h"
#import "QQNewsViewModel.h"

#import "ZFPlayer.h"

@interface QQNewsViewController ()<UITableViewDataSource, UITableViewDelegate, ZFPlayerDelegate>

/// TableView
@property (nonatomic, strong) UITableView *tableView;
/// 新闻视图模型数组
@property (nonatomic, strong) QQNewsListViewModel *newsListViewModel;

@property (nonatomic, strong) QQNewsVideoCell *cell;

@property (nonatomic, strong) ZFPlayerView        *playerView;

@end

@implementation QQNewsViewController

#pragma mark - Left Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.playerView resetPlayer];
}

#pragma mark - Load Data
- (void)loadData {
    
    [self.newsListViewModel loadNewsDataCompletion:^(BOOL isSuccessed) {
        
        if (!isSuccessed) {
            NSLog(@"%s 没有请求到数据", __FUNCTION__);
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerDownload:(NSString *)url {
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
//    NSString *name = [url lastPathComponent];
//    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
//    // 设置最多同时下载个数（默认是3）
//    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.navigationItem.title = @"新闻列表";
    [self tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsListViewModel.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQNewsViewModel *viewModel = self.newsListViewModel.newsList[indexPath.row];
    QQNewsVideoCell *cell = [QQNewsVideoCell qq_newsVideoCellWithTableView:tableView];
    cell.viewModel = viewModel;
    
    // 取到对应cell的model
//    __block ZFVideoModel *model        = self.dataSource[indexPath.row];
    // 赋值model
//    cell.model                         = model;
    __block NSIndexPath *weakIndexPath = indexPath;
    __block QQNewsVideoCell *weakCell     = cell;
    __weak typeof(self)  weakSelf      = self;
    // 点击播放的回调
    cell.playBlock = ^(UIButton *btn){
        
        // 分辨率字典（key:分辨率名称，value：分辨率url)
//        NSMutableDictionary *dic = @{}.mutableCopy;
//        for (ZFVideoResolution * resolution in model.playInfo) {
//            [dic setValue:resolution.url forKey:resolution.name];
//        }
//        // 取出字典中的第一视频URL
//        NSURL *videoURL = [NSURL URLWithString:dic.allValues.firstObject];
        
        NSLog(@"aaa");
        
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title            = viewModel.title_string;
        NSLog(@"playerModel.title = %@", playerModel.title);
        playerModel.videoURL         = viewModel.mp4_url;
        NSLog(@"playerModel.videoURL = %@", playerModel.videoURL);
        playerModel.placeholderImageURLString = viewModel.image_url_string;
        NSLog(@"playerModel.placeholderImageURLString = %@", playerModel.placeholderImageURLString);
        playerModel.scrollView       = weakSelf.tableView;
        NSLog(@"playerModel.scrollView = %@", playerModel.scrollView);
        playerModel.indexPath        = weakIndexPath;
        NSLog(@"playerModel.indexPath = %@", playerModel.indexPath);
//
//        NSDictionary *dic = @{
//                              @"aaa":@"http://120.25.226.186:32812/resources/videos/minion_01.mp4",
//                              @"aaa":@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"
//                              };
//
//        // 赋值分辨率字典
//        playerModel.resolutionDic    = dic;
//
        // player的父视图tag
        playerModel.fatherViewTag    = weakCell.newsImageView.tag;
//        playerModel.fatherViewTag    = weakCell.contentView.tag;
        NSLog(@"playerModel.fatherViewTag = %ld", playerModel.fatherViewTag);
        // 设置播放控制层和model
        [weakSelf.playerView playerControlView:nil playerModel:playerModel];
//        // 下载功能
////        weakSelf.playerView.hasDownload = YES;
//        // 自动播放
        [weakSelf.playerView autoPlayTheVideo];
        
//        // 判断不是播放失败的时候，隐藏预览图、播放按钮等（这段代码不影响播放功能）
//        if (weakSelf.playerView.state != ZFPlayerStateFailed) {
//            dispatch_async(dispatch_get_main_queue(), ^{
////                weakCell.newsImageView.hidden = YES;
//                weakSelf.playerView.hasPreviewView = NO;
//                weakSelf.playerView.hasPreviewView = YES;
//                weakCell.playButton.hidden = YES;
//            });
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
////                weakCell.newsImageView.hidden = NO;
//                weakSelf.playerView.hasPreviewView = YES;
//                weakSelf.playerView.hasPreviewView = NO;
//                weakCell.playButton.hidden = NO;
//            });
//        }
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didSelectRowAtIndexPath---%zd",indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQNewsViewModel *viewModel = self.newsListViewModel.newsList[indexPath.row];
    return viewModel.cellHeight;
}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 100;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (QQNewsListViewModel *)newsListViewModel {
    if (_newsListViewModel == nil) {
        _newsListViewModel = [[QQNewsListViewModel alloc] init];
    }
    return _newsListViewModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        // _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
        // 移除屏幕移除player
        // _playerView.stopPlayWhileCellNotVisable = YES;
//
//        _playerView.forcePortrait = NO;
        
        ZFPlayerShared.isLockScreen = YES;
        ZFPlayerShared.isStatusBarHidden = NO;
    }
    return _playerView;
}

@end

//
//  QQNetworkManager+QQNews.h
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNetworkManager.h"

@interface QQNetworkManager (QQNews)

- (void)loadNewsDataCompletion:(void (^)(NSArray *dataArray))completion;

@end

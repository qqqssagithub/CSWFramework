//
//  CSWNetworkMonitoringManager.m
//  CSWFramework
//
//  Created by 007 on 16/5/23.
//  Copyright © 2016年 陈少文. All rights reserved.
//

#import "CSWNetworkMonitoringManager.h"
#import "CSWFlashingAlertView.h"

@implementation CSWNetworkMonitoringManager

+ (instancetype)sharedManager {
    static CSWNetworkMonitoringManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[CSWNetworkMonitoringManager alloc] init];
    });
    return _manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _netState = [RealReachability reachabilityForInternetConnection];
    }
    return self;
}

- (void)startMonitoring {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    //self.netState = [Reachability reachabilityForInternetConnection];
    [self.netState startNotifier];
}

- (void)networkStateChange {
    [self checkNetworkState];
}

- (void)checkNetworkState {
    NSString *netTitle;
    //Reachability *nowNetState = [Reachability reachabilityForInternetConnection];
    if ([self.netState currentReachabilityStatus] == ReachableViaWiFi) {
        netTitle = @"此时为wifi网络";
    } else if ([self.netState currentReachabilityStatus] == ReachableViaWWAN) {
        netTitle = @"此时为4G/3G/2G网络";
    } else {
        netTitle = @"似乎已断开与互联网的连接";
    }
    [CSWFlashingAlertView initWithMessage:netTitle];
}

- (void)stopMonitoring {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [self.netState stopNotifier];
}

- (NetworkStatus)currentReachabilityStatus {
    return [self.netState currentReachabilityStatus];
}

@end

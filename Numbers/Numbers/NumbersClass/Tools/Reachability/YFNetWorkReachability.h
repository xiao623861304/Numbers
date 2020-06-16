//
//  YFNetWorkReachability.h
//  Numbers
//
//  Created by yan feng on 2020/6/14.
//  Copyright © 2020 Yan feng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YFNetWorkStatus) {
    YFNetWorkStatusNotReachable = 0,
    YFNetWorkStatusUnknown = 1,
    YFNetWorkStatusWWAN2G = 2,
    YFNetWorkStatusWWAN3G = 3,
    YFNetWorkStatusWWAN4G = 4,
    
    YFNetWorkStatusWiFi = 9,
};

extern NSString *kNetWorkReachabilityChangedNotification;

@interface YFNetWorkReachability : NSObject

/*!
 * Use to check the reachability of a given host name.
 */
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;

/*!
 * Use to check the reachability of a given IP address.
 */
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/*!
 * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
 */
+ (instancetype)reachabilityForInternetConnection;

+ (instancetype)reachabilityForLocalWiFi;

- (BOOL)startNotifier;

- (void)stopNotifier;

- (YFNetWorkStatus)currentReachabilityStatus;

@end



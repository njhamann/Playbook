//
//  connectionUtil.m
//  IT-Dealer
//
//  Created by Noah Hamann on 9/20/10.
//  Copyright (c) 2010 Ratchet. All rights reserved.
//

#import "connectionUtil.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

@implementation connectionUtil

- (BOOL)checkingInternetConncetion
{
	struct sockaddr_in zeroAddr;
	bzero(&zeroAddr, sizeof(zeroAddr));
	zeroAddr.sin_len = sizeof(zeroAddr);
	zeroAddr.sin_family = AF_INET;
	SCNetworkReachabilityRef target = 
	SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *) &zeroAddr);
	SCNetworkReachabilityFlags flags;
	SCNetworkReachabilityGetFlags(target, &flags);
	if (flags & kSCNetworkFlagsReachable){
		return YES;
	}else{
		if (flags & kSCNetworkReachabilityFlagsIsWWAN){
			return YES;
		}else{
			return NO;
		}
	}
	return NO;
}

@end

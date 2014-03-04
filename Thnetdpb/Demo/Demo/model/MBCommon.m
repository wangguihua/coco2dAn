//
//  MBCommon.m
//  Demo
//
//  Created by llbt_wgh on 14-1-22.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "MBCommon.h"

@implementation MBUserAllInfo
MB_SET_PROPERTY(method,@"p_loadInfo.action");
MB_SET_PROPERTY(account,@"account");
@end

@implementation MBUserLogInfo
MB_SET_PROPERTY(method,@"p_login.action");
MB_SET_PROPERTY(account,@"account");
MB_SET_PROPERTY(password,@"password");
@end


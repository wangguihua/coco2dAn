//
//  MBCommon.h
//  Demo
//
//  Created by llbt_wgh on 14-1-22.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import <Foundation/Foundation.h>

//查询客户登陆信息
@interface MBUserAllInfo : NSObject
MB_GET_PROPERTY(method);
MB_GET_PROPERTY(account);

@end
//查询客户登陆信息
@interface MBUserLogInfo : NSObject
MB_GET_PROPERTY(method);
MB_GET_PROPERTY(account);
MB_GET_PROPERTY(password);
@end
//
//  MBiiRequest.m
//  BOCMBCI
//
//  Created by Tracy E on 13-3-25.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import "MBIIRequest.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "MBGlobalUICommon.h"
#import "MBGlobalCore.h"
#import "BOCProgressHUD.h"
#import "MBException.h"
#import "MBConstant.h"
#import "MBCommon.h"
#import "UIApplicationAdditions.h"
#import "MBLoadingView.h"
#import "UIDevice+DevicePrint.h"

@implementation MBRequestItem

+ (MBRequestItem *)itemWithMethod:(NSString *)method
                           params:(NSDictionary *)params{
    return [[MBRequestItem alloc] initWithMethod:method
                                          params:params];
}

- (MBRequestItem *)initWithMethod:(NSString *)method
                           params:(NSDictionary *)params{
    self = [super init];
    if (self) {
        self.method = method;
        self.params = params;
    }
    return self;
}


@end



//--------------------------------------------------------------------------------------------------
@implementation MBIIRequest

static NSString* kURL(){
    NSString *url = [[NSUserDefaults standardUserDefaults] valueForKey:@"kURL"];
    return url ? url : kBIIBaseURL;
}



BOOL errorHandle(NSDictionary *result, BOOL showAlert, NSString *methodName){
    BOOL hasError = NO;
    @try {
        if ([MBNonEmptyString(result[@"_isException_"]) isEqualToString:kBooleanTrueString]) {
            hasError = YES;
            NSString *errorCode = result[@"code"];
            if (MBIsStringWithAnyText(errorCode) &&
                ([errorCode isEqualToString:@"otp.token.false.lock"] ||
                 [errorCode isEqualToString:@"otp.token.true.lock"] ||
                 [errorCode isEqualToString:@"role.invalid_user"] ||
                 [errorCode isEqualToString:@"validation.session_invalid"])) {
                    
                    if (![methodName isEqualToString:@"Logout"]) {
                        [[MBException defaultException] alertWithMessage:result[@"message"]];    
                    }
                    
                    return hasError;
                }
            return hasError;
        }
    }
    @catch (NSException *exception) {
        MBAlertNoTitle(@"报文格式有误");
    }
    return hasError;
}

//不能取消通讯的接口列表
BOOL shouldCancelRequest(NSString *method) {
    return ![@[
               
             ] containsObject:method];
}

+ (NSOperation *)requestWithItems:(NSArray *)items
                    info:(NSDictionary *)info
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *, id))failure{
    NSDictionary *headers = @{@"agent":     @"X-IOS",
                              @"device":    [[UIDevice currentDevice] requestHeaderDevice],
                              @"ext":       @"",
                              @"local":     @"zh_CN",
                              @"page":      @"FF001",
                              @"platform":  [[UIDevice currentDevice] requestHeaderPlatform],
                              @"plugins":   @"",
                              @"version":   [[UIDevice currentDevice] requestHeaderVersion]
                              };
    
    NSMutableArray *methods = [[NSMutableArray alloc] init];
    for (MBRequestItem *item in items) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:item.params];

                //如果接口要求上送的字段中有id字段，则不再加随机数id changed by dtt
        if (!params[@"id"]) {
            params[@"id"] = [NSString stringWithFormat:@"%ld",random()];
        }
        
        NSDictionary *method = @{@"method": item.method,
                                 @"header": headers,
                                 @"params": params};
        [methods addObject:method];
    }
    
    NSDictionary *postInfo = nil;
    if ([items count] == 1) {
        postInfo = methods[0];
    } else {
        postInfo = @{@"method": @"CompositeAjax",
                     @"header": headers,
                     @"params": @{@"methods": methods}};
    }
    
    NSString *postString = [NSString stringWithFormat:@"json=%@",[[postInfo JSONString] urlEncoded]];
    NSLog(@"post:%@",postString);
    
    
    

    
    BOOL shouldShowLoadingView = [info[MBRequest_ShowLoadingView] isEqualToString:@"no"] ? NO : YES;
    BOOL shouldShowErrorAlert = [info[MBRequest_ShowErrorAlert] isEqualToString:@"no"] ? NO : YES;
    BOOL canCancelRequest = YES;
    if (info[MBRequest_CanCancelRequest]) {
        canCancelRequest = [info[MBRequest_CanCancelRequest] isEqualToString:@"no"] ? NO : YES;
    } else {
        MBRequestItem *item = items[0];
        NSLog(@"method:%@",item.method);
        canCancelRequest = shouldCancelRequest(item.method);
    }
    MBLoadingView *loadingView = nil;
    if (shouldShowLoadingView) {
        loadingView = [[MBLoadingView alloc] init];
        loadingView.canCancel = canCancelRequest;
    }
    MBRequestItem *item = items[0];

    NSString *urlStr= @"";
    if ([item.method isEqualToString:@"p_login.action"]) {
        
        urlStr= [NSString stringWithFormat:@"%@%@%@?account=%@&password=%@",kURL(),@"permiss/",item.method,item.params[@"account"],item.params[@"password"]];
        
    }
    if ([item.method isEqualToString:@"p_loadInfo.action"]) {
        
        urlStr= [NSString stringWithFormat:@"%@%@%@?account=%@",kURL(),@"permiss/",item.method,item.params[@"account"]];
        
    }
    
    if ([item.params[@"keyWord"] isEqualToString:@"ALL"]) {
        if ([item.method isEqualToString:@"i_loadInfo.action"]) {
            
            urlStr= [NSString stringWithFormat:@"%@info/%@?type=%@&user_id=%@",kURL(),item.method,item.params[@"type"],item.params[@"id"]];
            
        }
    }
    if ([item.params[@"keyWord"] isEqualToString:@"THREE"]) {
        if ([item.method isEqualToString:@"i_loadInfo1.action"]) {
            
            
            urlStr= [NSString stringWithFormat:@"%@info/%@?infoId=%@",kURL(),item.method,item.params[@"infoId"]];

            
            NSLog(@"2222========%@",urlStr);
            
        }
    }

    if ([item.params[@"keyWord"] isEqualToString:@"FOUR"]) {
        if ([item.method isEqualToString:@"i_loadInfo1.action"]) {
            
            
            urlStr= [NSString stringWithFormat:@"%@info/%@?info1Id=%@&user_id=%@",kURL(),@"i_loadInfo2.action",item.params[@"infoId"],item.params[@"user_id"]];
            
            
            NSLog(@"2222========%@",urlStr);
            
        }
    }
    if ([item.params[@"keyWord"] isEqualToString:@"FIVE"]) {
        if ([item.method isEqualToString:@"i_loadInfo1.action"]) {
            
            
            urlStr= [NSString stringWithFormat:@"%@info/%@?infoId=%@",kURL(),item.method,item.params[@"infoId"]];
            
            
            NSLog(@"2222========%@",urlStr);
            
        }
    }

    if ([item.params[@"keyWord"] isEqualToString:@"SIX"]) {
        if ([item.method isEqualToString:@"i_loadInfo1.action"]) {
            
            
            urlStr= [NSString stringWithFormat:@"%@info/%@?infoId=%@",kURL(),item.method,item.params[@"infoId"]];
            
            
            NSLog(@"2222========%@",urlStr);
            
        }
    }
    
    if ([item.params[@"keyWord"] isEqualToString:@"SEVE"]) {
        if ([item.method isEqualToString:@"i_loadInfo1.action"]) {
            
            
            urlStr= [NSString stringWithFormat:@"%@info/%@?infoId=%@",kURL(),item.method,item.params[@"infoId"]];
            
            
            NSLog(@"2222========%@",urlStr);
            
        }
    }
    if ([item.params[@"keyWord"] isEqualToString:@"search"]) {
        if ([item.method isEqualToString:@"q_query.action"]) {
            
            
            urlStr= [NSString stringWithFormat:@"%@query/%@?condition=%@",kURL(),item.method,item.params[@"condition"]];
            
            
            NSLog(@"2222========%@",urlStr);
            
        }
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [urlRequest setTimeoutInterval:300.0];
    
    NSLog(@"\n------【Request】------\n%@\n%@",[urlRequest allHTTPHeaderFields], [postInfo JSONString]);
    
    __block NSInteger statusCode = -1;
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [loadingView hide];
        NSLog(@"-------[Response]-----------\n%@ %ld \n%@",[response allHeaderFields],(long)[response statusCode],[JSON JSONString]);
        
        statusCode = [response statusCode];
        if (statusCode == 200) {
            if (JSON) {
                MBRequestItem *item = items[0];
                if (!errorHandle(JSON, shouldShowErrorAlert, item.method)) {
                    //兼容老接口
                    success(JSON);
                }else{
                    failure(nil, JSON);
                }
            }else{
                if (shouldShowErrorAlert) {
                    
                    [[MBException defaultException] alertWithMessage:@"后台系统返回异常"];

                }
                failure(nil, JSON);
            }
        } else {
            if (shouldShowErrorAlert) {
                [[MBException defaultException] alertWithErrorCode:[NSString stringWithFormat:@"%ld",(long)statusCode]];
            }
            failure(nil, JSON);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [loadingView hide];
        
        NSLog(@"error:%@",error);
        NSLog(@"-------[Response]-----------\n%@ %ld \n%@",[response allHeaderFields],(long)[response statusCode],[JSON JSONString]);
        
        statusCode = [response statusCode];
        if (shouldShowErrorAlert) {
            [[MBException defaultException] alertWithErrorCode:[NSString stringWithFormat:@"%ld",(long)[error code]]];
        }
        failure(error, JSON);
    }];
    [operation start];
    loadingView.requestOperation = operation;
    [loadingView show];
    
    return operation;
}

+ (void)requestWithItems:(NSArray *)items
                 success:(void (^)(id JSON))success
                 failure:(void (^)(NSError *error, id JSON))failure{
    [MBIIRequest requestWithItems:items info:nil success:success failure:failure];
}

@end

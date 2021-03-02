//
//  HttpRequest.m
//  AFNetworking封装
//
//  Created by 侯宝伟 on 2019/3/30.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "HttpRequest.h"
#import "MainViewController.h"
#import "DriverMainViewController.h"

@implementation HttpRequest
static NSString * const RequestSuccessCode = @"1";              // 请求成功
static NSString * const RequestTokenInvalidCode = @"4001";      // token失效
static NSString * const RequestFailureText = @"网络连接错误!";    // 请求失败错误信息
static NSString * const ResponseMessageKey = @"msg";            // 返回结果提示信息

static id _instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}
- (instancetype)init {
    if (self = [super init]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.operationQueue.maxConcurrentOperationCount = 5;       // 最大并发数
        manager.requestSerializer.timeoutInterval = 30;     // 请求超时时间
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        self.manager = manager;
    }
    return self;
}


#pragma mark - GET请求
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure {
    
    if (URLString.length == 0) {
        failure(CustomErrorCode, @"传入的url为空");
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    NSDictionary *headerParams = @{
        @"token" : BWCheckString([BWUserDefaults userToken]),
    };
    
    NSLog(@"token ====== %@", BWCheckString([BWUserDefaults userToken]));
    NSLog(@"url ======= %@", url);
    NSLog(@"parameters ======= %@", parameters);

    [self.manager GET:url parameters:parameters headers:headerParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject ======= %@", responseObject);
        [self dealSuccessResultWithResponseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dealErrorResultWithError:error failure:failure];
    }];
}


#pragma mark - POST请求
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure {
    
    if (URLString.length == 0) {
        failure(CustomErrorCode, @"传入的url为空");
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    NSDictionary *headerParams = @{
        @"token" : BWCheckString([BWUserDefaults userToken]),
    };
    
    NSLog(@"token ====== %@", BWCheckString([BWUserDefaults userToken]));
    NSLog(@"url ======= %@", url);
    NSLog(@"parameters ======= %@", parameters);
    
    [self.manager POST:url parameters:parameters headers:headerParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject ======= %@", responseObject);
        [self dealSuccessResultWithResponseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dealErrorResultWithError:error failure:failure];
    }];
}


#pragma mark - POST/GET网络请求
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure {

    switch (type) {
        case HttpRequestTypeGet:
        {
            [self getWithURLString:URLString parameters:parameters success:success failure:failure];
        }
            break;
        case HttpRequestTypePost:
        {
            [self postWithURLString:URLString parameters:parameters success:success failure:failure];
        }
            break;
    }
}


#pragma mark - DELETE请求
- (void)deleteWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure {
    
    if (URLString.length == 0) {
        failure(CustomErrorCode, @"传入的url为空");
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    NSDictionary *headerParams = @{
        @"token" : BWCheckString([BWUserDefaults userToken]),
    };

    [self.manager DELETE:url parameters:parameters headers:headerParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealSuccessResultWithResponseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dealErrorResultWithError:error failure:failure];
    }];
}


#pragma mark - PUT请求
- (void)putWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure {
    
    if (URLString.length == 0) {
        failure(CustomErrorCode, @"传入的url为空");
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    NSDictionary *headerParams = @{
        @"token" : BWCheckString([BWUserDefaults userToken]),
    };
    
    [self.manager.requestSerializer setValue:BWCheckString([BWUserDefaults userToken]) forHTTPHeaderField:@"token"];
    [self.manager PUT:url parameters:parameters headers:headerParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealSuccessResultWithResponseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dealErrorResultWithError:error failure:failure];
    }];
}


#pragma mark - 上传文件
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray<UploadParam *> *)uploadParams
                   progress:(ProgressBlock)progress
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    NSDictionary *headerParams = @{
        @"token" : BWCheckString([BWUserDefaults userToken]),
    };
    
    [self.manager POST:url parameters:parameters headers:headerParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UploadParam *uploadParam in uploadParams) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealSuccessResultWithResponseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dealErrorResultWithError:error failure:failure];
    }];
}


#pragma mark - 下载数据
- (void)downLoadWithURLString:(NSString *)URLString
             downloadFilePath:(NSString *)downloadFilePath
                     progress:(ProgressBlock)progress
                      success:(SuccessBlock)success
                      failure:(FailureBlock)failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 拼接缓存目录
        NSString *downloadPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadFilePath ? downloadFilePath : @"Download"];
        // 打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // 创建Download目录
        [fileManager createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
        // 拼接文件路径
        NSString *filePath = [downloadPath stringByAppendingPathComponent:response.suggestedFilename];
        // 返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self dealErrorResultWithError:error failure:failure];
    }];
    [downLoadTask resume];
}


#pragma mark - 网络状态监测
- (void)setReachabilityStatusChangeBlock:(void(^)(AFNetworkReachabilityStatus status))block {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                // 未知网络
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
                // 没有网络
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
                // 手机自带网络
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"当前使用的是2G/3G/4G网络");
                break;
                // WIFI
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"当前在WIFI网络下");
                break;
        }
        if (block) {
            block(status);
        }
    }];
}

- (void)stopMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager stopMonitoring];
}


#pragma mark - 返回结果处理

/// 正确结果处理方法
- (void)dealSuccessResultWithResponseObject:(id)responseObject success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString *responseCode = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
    if ([responseCode isEqualToString:RequestSuccessCode]) {
        if ([[responseObject allKeys] containsObject:@"data"]) {
            if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDict = responseObject[@"data"];
                success(dataDict);
            } else if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                NSArray *dataArray = responseObject[@"data"];
                success(dataArray);
            } else {
                success(responseObject);
            }
        } else {
            success(responseObject);
        }
    } else if ([responseCode isEqualToString:RequestTokenInvalidCode]) {
        //token失效 退出登录
        [self logOutAndClearUserInfo];
    } else {
        NSString *errorText = [NSString stringWithFormat:@"%@", responseObject[ResponseMessageKey]];
        failure(responseCode, errorText);
    }
}

/// 错误结果处理
- (void)dealErrorResultWithError:(NSError *)error failure:(FailureBlock)failure {
    failure(CustomErrorCode, RequestFailureText);
    NSLog(@"error: %@", error);
}

#pragma mark 退出登录
/// 退出登录
- (void)logOutAndClearUserInfo {
    [SVProgressHUD showInfoWithStatus:@"登录过期, 请重新登录!"];
    // 清除用户数据
    [BWUserDefaults saveUserInfo:nil];
    NSLog(@"Bundle Identifier : %@", BWBundleIdentifier);
    // 设置根控制器
    if ([BWBundleIdentifier isEqualToString:@"com.qttx.chetuotuodriver"]) {
        DriverMainViewController *rootController = [[DriverMainViewController alloc] mainInit];
        [[UIApplication sharedApplication].delegate.window setRootViewController:rootController];
    } else {
        MainViewController *rootController = [[MainViewController alloc] mainInit];
        [[UIApplication sharedApplication].delegate.window setRootViewController:rootController];
    }
}
    

@end

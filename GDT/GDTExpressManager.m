//
//  GDTExpressManager.m
//  Recipe
//
//  Created by fcx on 2017/10/8.
//  Copyright © 2017年 冯 传祥. All rights reserved.
//

#import "GDTExpressManager.h"
#import "GDTNativeExpressAd.h"

@interface GDTExpressManager () <GDTNativeExpressAdDelegete>

@property (nonatomic, retain) GDTNativeExpressAd *nativeExpressAd;
@property (nonatomic, copy) void(^adArrayHandle)(NSArray *adArray);//广告加载成功回调

@end

@implementation GDTExpressManager

- (instancetype)initWithSize:(CGSize)size
                      gdtKey:(NSString *)gdtKey
                 placementId:(NSString *)placementId
                     adCount:(NSInteger)adCount
                      finish:(void(^)(NSArray *adArray))finish {
    if (self = [super init]) {
        self.adArrayHandle = finish;
        self.nativeExpressAd = [[GDTNativeExpressAd alloc] initWithAppkey:gdtKey placementId:placementId adSize:size];
        self.nativeExpressAd.delegate = self;
        [self.nativeExpressAd loadAd:(int)adCount];
    }
    return self;
}

#pragma mark - GDTNativeExpressAdDelegete
/**
 * 拉取广告成功的回调
 */
- (void)nativeExpressAdSuccessToLoad:(GDTNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof GDTNativeExpressAdView *> *)views
{
    if (_adArrayHandle) {//多个广告
        dispatch_async(dispatch_get_main_queue(), ^{
            _adArrayHandle(views);
        });
    }
}

/**
 * 拉取广告失败的回调
 */
- (void)nativeExpressAdFailToLoad:(GDTNativeExpressAd *)nativeExpressAd error:(NSError *)error {
    
}
/**
 * 拉取广告失败的回调
 */
- (void)nativeExpressAdRenderFail:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewRenderSuccess:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewClicked:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}

@end

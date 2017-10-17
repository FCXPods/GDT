//
//  FCXExpressView.m
//  PrivacyPhoto
//
//  Created by fcx on 2017/10/7.
//  Copyright © 2017年 冯 传祥. All rights reserved.
//

#import "FCXExpressView.h"
#import "GDTNativeExpressAd.h"
#import "GDTNativeExpressAdView.h"

@interface FCXExpressView () <GDTNativeExpressAdDelegete> {
    CGRect _adFrame;
}

// 用于请求原生模板广告，注意：不要在广告打开期间释放！
@property (nonatomic, retain) GDTNativeExpressAd *nativeExpressAd;

@end

@implementation FCXExpressView

- (instancetype)initWithFrame:(CGRect)frame
                   controller:(UIViewController *)controller
                       gdtKey:(NSString *)gdtKey
                  placementId:(NSString *)placementId
                   edgeInsets:(UIEdgeInsets)edgeInsets {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _adFrame = CGRectMake(edgeInsets.left, edgeInsets.top, frame.size.width - edgeInsets.left - edgeInsets.right, frame.size.height - edgeInsets.top - edgeInsets.bottom);

        self.nativeExpressAd = [[GDTNativeExpressAd alloc] initWithAppkey:gdtKey placementId:placementId adSize:_adFrame.size];
        self.nativeExpressAd.delegate = self;
        
        // 拉取5条广告
        [self.nativeExpressAd loadAd:1];

    }
    return self;
}

#pragma mark - GDTNativeExpressAdDelegete
/**
 * 拉取广告成功的回调
 */
- (void)nativeExpressAdSuccessToLoad:(GDTNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof GDTNativeExpressAdView *> *)views
{
    [self.subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GDTNativeExpressAdView *adView = (GDTNativeExpressAdView *)obj;
        [adView removeFromSuperview];
    }];
    
    if (views.count) {
        // 取一个GDTNativeExpressAdView
        GDTNativeExpressAdView *expressView = views[0];
        // 设置frame，开发者自己设置
        expressView.frame = _adFrame;
        expressView.controller = [self controller];
        [expressView render];
        //添加View的时机，开发者控制
        [self addSubview:expressView];
        if (_finishHandle) {
            _finishHandle(self);
        }
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

- (UIViewController *)controller {
    UIResponder *responder = self;
    while ((responder = responder.nextResponder)) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end

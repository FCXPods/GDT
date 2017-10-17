//
//  FCXExpressView.h
//  PrivacyPhoto
//
//  Created by fcx on 2017/10/7.
//  Copyright © 2017年 冯 传祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCXExpressView : UIView

@property (nonatomic, copy) void(^finishHandle)(FCXExpressView *expressView);//广告加载成功回调

- (instancetype)initWithFrame:(CGRect)frame
                   controller:(UIViewController *)controller
                       gdtKey:(NSString *)gdtKey
                  placementId:(NSString *)placementId
                   edgeInsets:(UIEdgeInsets)edgeInsets;

@end

//
//  GDTExpressManager.h
//  Recipe
//
//  Created by fcx on 2017/10/8.
//  Copyright © 2017年 冯 传祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDTExpressManager : NSObject

- (instancetype)initWithSize:(CGSize)size
                      gdtKey:(NSString *)gdtKey
                 placementId:(NSString *)placementId
                     adCount:(NSInteger)adCount
                      finish:(void(^)(NSArray *adArray))finish;
@end

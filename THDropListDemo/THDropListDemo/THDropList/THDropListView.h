//
//  THDropList.h
//  KCBuinessKey
//
//  Created by eddy on 2017/6/23.
//  Copyright © 2017年 www.kuang-chi.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THDropListView : UIView

@property (nonatomic, strong) NSArray *dataArray;

- (instancetype)initWithData:(NSArray *)array;

@end

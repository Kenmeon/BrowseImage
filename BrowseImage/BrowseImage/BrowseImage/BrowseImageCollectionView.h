//
//  BrowseImageCollectionView.h
//  BrowseImage
//
//  Created by zhanglongtao on 17/1/16.
//  Copyright © 2017年 hanju001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseImageCollectionView : UIView

@property(nonatomic,strong) NSArray *dataSourceArray;

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource;

@end

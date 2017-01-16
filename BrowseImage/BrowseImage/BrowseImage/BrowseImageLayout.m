//
//  BrowseImageLayout.m
//  BrowseImage
//
//  Created by zhanglongtao on 17/1/16.
//  Copyright © 2017年 hanju001. All rights reserved.
//

#import "BrowseImageLayout.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@implementation BrowseImageLayout

- (void)prepareLayout
{
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
}
@end

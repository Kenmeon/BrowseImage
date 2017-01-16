//
//  BrowseImageCollectionCell.m
//  BrowseImage
//
//  Created by zhanglongtao on 17/1/16.
//  Copyright © 2017年 hanju001. All rights reserved.
//

#import "BrowseImageCollectionCell.h"
#import "UIImageView+AFNetworking.h"


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@implementation BrowseImageCollectionCell

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    [self.contentImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 1.8;
    self.scrollView.bounces = NO;
    
    self.contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    [self.scrollView addSubview:self.contentImageView];
    
    self.contentImageView.userInteractionEnabled = YES;
 
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSArray *arr = scrollView.subviews;
    for (UIView *obj in arr) {
        if([obj isKindOfClass:[UIImageView class]]){
            
            return obj;
        }
    }
    return nil;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGRect kBounds = scrollView.bounds;
    self.contentImageView.center = CGPointMake(kBounds.origin.x + kBounds.size.width/2, (kBounds.origin.y +kBounds.size.height)/2);
}

@end

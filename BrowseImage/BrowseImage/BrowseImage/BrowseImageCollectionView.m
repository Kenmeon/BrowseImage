//
//  BrowseImageCollectionView.m
//  BrowseImage
//
//  Created by zhanglongtao on 17/1/16.
//  Copyright © 2017年 hanju001. All rights reserved.
//

#import "BrowseImageCollectionView.h"
#import "BrowseImageCollectionCell.h"
#import "BrowseImageLayout.h"
#import "UIColor+iOSColorFromJava.h"
#import "ImageModel.h"

#define kBrowseImageCellId @"kBrowseImageCellId"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface BrowseImageCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UIView *backGroundView;

@end

@implementation BrowseImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource
{
    if (self = [super initWithFrame:frame]){
        
        self.dataSourceArray = dataSource;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    BrowseImageLayout *flowLayout = [[BrowseImageLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BrowseImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:kBrowseImageCellId];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    [self addSubview:self.collectionView];
    
    UITapGestureRecognizer *tapGestr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCollectionView:)];
    [self.collectionView addGestureRecognizer:tapGestr];
    
    [self creatTextFieldView];
}
- (void)tapCollectionView:(UITapGestureRecognizer *)gr
{
    self.backGroundView.hidden = !self.backGroundView.hidden;
}
-(void)creatTextFieldView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, kScreenHeight-150)];
    view.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0];
    [self addSubview:view];
    
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-150, kScreenWidth, 150)];
    [backGroundView setBackgroundColor:[UIColor iOSColorFromJava:@"#1b1b1b"]];
    [backGroundView setAlpha:0.5];
    [self addSubview:backGroundView];
    self.backGroundView = backGroundView;
    
    UITextView *comment = [[UITextView alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth-30, 120)];
    comment.editable = NO;
    [comment setBackgroundColor:[UIColor iOSColorFromJava:@"#1b1b1b"]];
    comment.showsVerticalScrollIndicator = NO;
    self.textView = comment;
    
    
    [backGroundView addSubview:comment];
    
    [self setCommentStr:0];
    
}
// 给数据
-(void)setCommentStr:(NSInteger)index{
    
    // 评论
    ImageModel *model = self.dataSourceArray[index];
    NSString *str = [NSString stringWithFormat:@"%ld/%ld %@",(index + 1),self.dataSourceArray.count,model.content];
    NSString *minStr = [NSString stringWithFormat:@"%ld",self.dataSourceArray.count];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    
    // 显示图片张数的设置
    NSDictionary *dic1 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle};
    
    
    NSDictionary *dic2 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17],NSParagraphStyleAttributeName:paragraphStyle};
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str attributes:dic2];
    NSRange range = NSMakeRange(2, minStr.length);
    [attrStr addAttributes:dic1 range:range];
    
    [self.textView scrollRangeToVisible:NSMakeRange(0, 1)];
    self.textView.attributedText = attrStr;
    
}

#pragma mark ---UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrowseImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBrowseImageCellId forIndexPath:indexPath];
    ImageModel *mdoel = self.dataSourceArray[indexPath.item];
    
    cell.backgroundColor = [UIColor blackColor];
    cell.imageUrl = mdoel.imageUrl;
    [cell.scrollView setZoomScale:1.0];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.backGroundView.hidden = !self.backGroundView.hidden;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = round(scrollView.contentOffset.x / kScreenWidth);
    
    [self setCommentStr:index];
    

}

@end

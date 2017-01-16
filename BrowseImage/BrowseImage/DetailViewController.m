//
//  DetailViewController.m
//  BrowseImage
//
//  Created by zhanglongtao on 17/1/16.
//  Copyright © 2017年 hanju001. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "ImageModel.h"
#import "BrowseImageCollectionView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface DetailViewController ()
@property(nonatomic,strong)NSMutableArray *dataSourceArr;
@property(nonatomic,strong) BrowseImageCollectionView *brwoseview;
@end

@implementation DetailViewController
-(NSMutableArray *)dataSourceArr{
    if (_dataSourceArr==nil) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self loadData];
    
    
}
- (void)setupUI
{
    BrowseImageCollectionView *brwoseview = [[BrowseImageCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withDataSource:self.dataSourceArr];
    [self.view addSubview:brwoseview];
}
- (void)loadData{
    
    [self findShowImageDetaileImageId:@"163895" Completion:^(NSDictionary *body, NSError *error) {
        NSLog(@"%@",body);
        if (!error) {
            if ([body[@"errorCode"] isEqualToString:@"1"]) {
                
                NSArray *array = body[@"body"];
                if (array.count != 0)
                {
                    for (NSDictionary *dic in array) {
                        ImageModel *model = [ImageModel new];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.dataSourceArr addObject:model];
                    }
                    NSLog(@"%@",self.dataSourceArr);
                    
                    [self setupUI];
                }
                
            }
        }
        
    }];
}
-(void)findShowImageDetaileImageId:(NSString *)imageId Completion:(void (^) (NSDictionary * body, NSError *error))completion{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *postName = @"news/findImageDetail";
    
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html", @"text/plain", nil];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"
                     forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parameters;
    parameters = [NSDictionary
                  dictionaryWithObjectsAndKeys:imageId,@"id",nil];
    
    [manager POST:[NSString stringWithFormat:@"http://appapi.city-wifi.com/hj.server/services/%@", postName] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization
                              JSONObjectWithData:responseObject
                              options:NSJSONReadingMutableContainers
                              error:nil];
        
        completion(dict,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"网络请求失败");
        NSLog(@"error = %@", error);
        completion(nil,error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

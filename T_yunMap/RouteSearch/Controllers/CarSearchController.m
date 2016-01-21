//
//  CarSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CarSearchController.h"
#import "NormalCollectionViewCell.h"
#import "CarSearchCollectionHeader.h"

#define kHeaderHeight 50
@interface CarSearchController ()<UICollectionViewDelegate, UICollectionViewDataSource> {

    AMapSearchAPI *_routeSearch;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UILabel *strategyLB;

@end

@implementation CarSearchController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeader = @"CollectionHeaderReusableView";

- (NSArray *)dataArray {

    if (_dataArray == nil) {
        _dataArray = @[@"速度优先",
                       @"费用优先",
                       @"距离优先",
                       @"不走快速路",
                       @"躲避拥堵",
                       @"多策略",
                       @"不走高速",
                       @"不走高速且避免收费",
                       @"躲避收费和拥堵",
                       @"不高速且避收费拥堵"];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stateButtonName = @"default_path_searchbtn_car";
    self.searchType = SearchTypeCar;
    
    [self customCollectionView];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customCollectionView {

    //设置layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(ScreenSize.width / 4, 50);
    layout.minimumLineSpacing = Space_Normal_Eight;
    layout.minimumInteritemSpacing = Space_Normal_Eight;
    
    // 设置内间距
    layout.sectionInset = UIEdgeInsetsMake(Space_Normal_Ten, Space_Normal_Ten, Space_Normal_Ten, Space_Normal_Ten);
    
    layout.headerReferenceSize = CGSizeMake(self.view.xmy_width, kHeaderHeight);
    
    //设置frame
    CGFloat originY = CGRectGetMaxY(self.destinationTF.frame) + Space_Normal_Ten * 3;
    CGRect rect = CGRectMake(0, originY, self.view.xmy_width, self.view.xmy_height - originY - Space_Normal_Eight);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NormalCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CarSearchCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader];
}

//重写
  /**路径导航搜索*/
- (void)searchRoute {

    NSLog(@"search");
   
        
        _routeSearch = [[AMapSearchAPI alloc] init];
        _routeSearch.delegate = self;
    
//    NSLog(@"%f%f--%f%f", self.originLocation.latitude, self.originLocation.longitude, self.destinationLocation.latitude, self.destinationLocation.longitude);
        //构造AMapDrivingRouteSearchRequest对象 设置驾车路径规划请求参数
        AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
        request.origin = [AMapGeoPoint locationWithLatitude:self.originLocation.latitude longitude:self.originLocation.longitude];
        request.destination = [AMapGeoPoint locationWithLatitude:self.destinationLocation.latitude longitude:self.destinationLocation.longitude];
        /// 驾车导航策略：0-速度优先（时间）；1-费用优先（不走收费路段的最快道路）；2-距离优先；3-不走快速路；4-结合实时交通（躲避拥堵）；5-多策略（同时使用速度优先、费用优先、距离优先三个策略）；6-不走高速；7-不走高速且避免收费；8-躲避收费和拥堵；9-不走高速且躲避收费和拥堵
        request.strategy = 2;
        request.requireExtension = YES;
        
        [_routeSearch AMapDrivingRouteSearch:request];
    [SVProgressHUD showWithStatus:@"搜索中"];
    
}


#pragma mark - <AMapSearchDelegate>
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {

    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    [SVProgressHUD dismiss];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLB.text = self.dataArray[indexPath.row];
    cell.titleLB.font = [UIFont systemFontOfSize:16];
    cell.titleLB.numberOfLines = 0;
    cell.titleLB.textColor = [UIColor whiteColor];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CarSearchCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        header.titleLB.text = [NSString stringWithFormat:@"当前策略:%@", self.dataArray[indexPath.row] ];
        self.strategyLB = header.titleLB;
        header.layer.cornerRadius = 20;
        
        return header;
    }
    
    return nil;
}

#pragma mark <UICollectionDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {



    
    
    self.strategyLB.text = [NSString stringWithFormat:@"当前策略:%@", self.dataArray[indexPath.row]];
    
    

}

@end

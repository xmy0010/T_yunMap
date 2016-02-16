//
//  BusSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/12.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusSearchController.h"
#import "MAMapView+Singleton.h"
#import "MAUserLocation+XMYExtension.h"
#import "BusResultViewController.h"
#import "CarSearchCollectionHeader.h"
#import "NormalCollectionViewCell.h"

#define kHeaderHeight 50

@interface BusSearchController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UILabel *strategyLB;
@property (nonatomic, assign) NSInteger strategy;


@end

@implementation BusSearchController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeader = @"CollectionHeaderReusableView";

- (NSArray *)dataArray {

    if (_dataArray == nil) {
        _dataArray = @[@"最快捷模式",
                       @"最经济模式",
                       @"最少换乘模式",
                       @"最少步行模式",
                       @"最舒适模式",
                       @"不乘地铁模式"];
        
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stateButtonName = @"default_path_searchbtn_bus";
    self.searchType = SearchTypeBus;
    
    [self customCollectionView];
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

//重写父类方法进行搜索
- (void)searchRoute {

    AMapTransitRouteSearchRequest *request = [[AMapTransitRouteSearchRequest alloc] init];
    request.origin = self.originLocation;
    request.destination = self.destinationLocation;
    request.city = [MAMapView shareMap].userLocation.userCity;
    request.strategy = self.strategy;
    
    [self.search AMapTransitRouteSearch:request];
    [SVProgressHUD showWithStatus:@"搜索中"];
}


#pragma mark - AMapSearchDelegate
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {

    
    AMapRoute *route = response.route;
    BusResultViewController *resultVC = [[BusResultViewController alloc] init];
    resultVC.route = route;
    resultVC.originName = self.originTF.text;
    resultVC.destinationName = self.destinationTF.text;
    resultVC.strantegy = self.dataArray[self.strategy];
    
    [SVProgressHUD dismiss];
    [self.navigationController pushViewController:resultVC animated:YES];
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
    
    self.strategy = indexPath.row;
    self.strategyLB.text = [NSString stringWithFormat:@"当前策略:%@", self.dataArray[indexPath.row]];
    
    
    
}

@end

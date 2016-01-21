//
//  CityCollectionViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/19.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CityCollectionViewController.h"
#import "NormalCollectionViewCell.h"
#import "CollectionHeaderReusableView.h"
#import "WeatherResultViewController.h"



@interface CityCollectionViewController () <AMapSearchDelegate> {
    
    AMapSearchAPI *_search;
}

@property (nonatomic, strong) WeatherResultViewController *weatherVC;

@end

@implementation CityCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeader = @"CollectionHeaderReusableView";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"选择城市";
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"topic_Cell_Bg"]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NormalCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader];

    [self customCollectionView];
}

- (void)setDataArray:(NSArray *)dataArray {

    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)customCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //    self.collectionView.frame = CGRectMake(Space_Normal_Eight, 0, ScreenSize.width - Space_Normal_Eight * 2, ScreenSize.height);
    
    
    flowLayout.itemSize = CGSizeMake(self.collectionView.xmy_width / 5, kItemHeight);
    //设置单元格间距
    flowLayout.minimumInteritemSpacing = Space_Normal_Eight;
    flowLayout.minimumLineSpacing = Space_Normal_Eight;
    
    // 设置内间距
    flowLayout.sectionInset = UIEdgeInsetsMake(Space_Normal_Ten, Space_Normal_Ten, Space_Normal_Ten, Space_Normal_Ten);
    
    //设置headerReferenceSize
    flowLayout.headerReferenceSize = CGSizeMake(200, 50);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CollectionHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        header.titleLB.text = self.province;
        
        return header;
    }
    
    return nil;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NormalCollectionViewCell *cell = (NormalCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *city =  cell.titleLB.text;
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
    request.city = city;
    request.type = AMapWeatherTypeLive;
    
    [_search AMapWeatherSearch:request];
    
    
    [SVProgressHUD showWithStatus:@"查询中..."];
    
}

#pragma mark - <AMapSearchDelegate>
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {

    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
}

- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response {

    if (request.type == AMapWeatherTypeLive) {
        
        UIStoryboard *weatherSb = [UIStoryboard storyboardWithName:@"WeatherStoryboard" bundle:nil];
        self.weatherVC = [weatherSb instantiateViewControllerWithIdentifier:@"WeatherResultViewController"];
       
         self.weatherVC.live = [response.lives firstObject];
         [self.navigationController pushViewController:self.weatherVC animated:YES];
        [SVProgressHUD dismiss];
    }
}

@end

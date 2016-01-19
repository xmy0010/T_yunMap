//
//  ProvinceCollectionViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/18.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "ProvinceCollectionViewController.h"
#import "ChoseCitys.h"
#import "NormalCollectionViewCell.h"
#import "LocationCollectionViewCell.h"
#import "CollectionHeaderReusableView.h"

#import "CityCollectionViewController.h"



#define kItemHeight 30.
@interface ProvinceCollectionViewController () <UICollectionViewDelegateFlowLayout> {

    AMapSearchAPI *_search;
}

@property (nonatomic, strong) NSArray *hotCitys;
@property (nonatomic, strong) NSArray *provinces;

@end

@implementation ProvinceCollectionViewController

static NSString * const locationReuseIdentifier = @"LocationCell";
static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeader = @"CollectionHeaderReusableView";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查询城市";
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"topic_Cell_Bg"]];
    
    [self customCollectionView];
    [self setupDataArray];
    
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LocationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:locationReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NormalCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader];
    

    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)setupDataArray {

    self.hotCitys = [ChoseCitys choseCitysWithName:@"hotCitys"];
    self.provinces = [ChoseCitys choseCitysWithName:@"provinces"];
    
    [self.collectionView reloadData];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0) {
        
        return self.hotCitys.count;
    } else {
        return self.provinces.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            LocationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:locationReuseIdentifier forIndexPath:indexPath];
            cell.titleLB.text = self.hotCitys[indexPath.row];
            
            return cell;
        } else {
        
            NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            cell.titleLB.text = self.hotCitys[indexPath.row];
            
            return cell;
        }
    } else {
    
        NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.titleLB.text = self.provinces[indexPath.row];
        
        return cell;
    }
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return nil;
    }
    
    if (indexPath.section == 0) {
        CollectionHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        header.titleLB.text = @"热门城市";
        
        return header;
    } else {
        CollectionHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        header.titleLB.text = @"选择省份";
        
        return header;
    }
    
}

//设置组头和组尾, 必须要复用


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        NormalCollectionViewCell *cell = (NormalCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        NSString *province =  cell.titleLB.text;
        
        CityCollectionViewController *cityVC = [[CityCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewLayout alloc] init]];
        cityVC.province = province;
        cityVC.dataArray = [ChoseCitys choseCitysWithName:province];
        
        [self.navigationController pushViewController:cityVC animated:YES];
        
    }
    
}

@end

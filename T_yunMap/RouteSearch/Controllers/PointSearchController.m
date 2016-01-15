//
//  PointSearchController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/13.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "PointSearchController.h"
#import "MAUserLocation+XMYExtension.h"


@interface PointSearchController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, AMapSearchDelegate> {
    

}



@property (nonatomic, strong) AMapInputTipsSearchRequest *tipsRequest;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *currentTips;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) AMapTip *resultTip;

//历史记录 可做本地持久化
@property (nonatomic, strong) NSMutableArray *selectedTips;

@end

@implementation PointSearchController



- (NSMutableArray *)selectedTips {

    
}

- (NSArray *)currentTips {
    
    if (_currentTips == nil) {
        _currentTips = @[].mutableCopy;
    }
    
    return _currentTips;
}

- (AMapInputTipsSearchRequest *)tipsRequest {

    if (_tipsRequest == nil) {
        _tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    }
    
    return _tipsRequest;
}

- (AMapSearchAPI *)search {

    if (_search == nil) {
        
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    
    return _search;
}


- (UITableView *)tableView {

    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.bounces = NO;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (NSMutableArray *)dataArray {

    if (_dataArray == nil) {
        
        _dataArray = @[].mutableCopy;
    }
    
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
    
    [self createSearchController];
}

- (void)createSearchController {

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    //searchBar自适应父视图
    [_searchController.searchBar sizeToFit];
    
    //不显示背景
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    //设置更新数据代理
    _searchController.searchResultsUpdater = self;
    
    //将UISearchController自带的UISearchBar设置为UITableView的表头View
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    //设置搜索条的代理
    _searchController.searchBar.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_searchController.active) {
        return self.dataArray.count;
    } else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    AMapTip *tip = self.dataArray[indexPath.row];
    if (_searchController.active) {
        cell.textLabel.text = tip.name;
    }
    
    
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    AMapTip *resultTip = self.currentTips[indexPath.row];
    if (_PointSearchBlock) {
        _PointSearchBlock(resultTip);
    }
    
    //做一下本地持久化
    [[NSUserDefaults standardUserDefaults] setObject:resultTip forKey: ];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - <UISearchResultUpdation>
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSString *keyWords = _searchController.searchBar.text;
#warning 分类那边出了技术问题  暂时测试city 一律设为成都
//    NSString *city = self.mapView.userLocation.userCity;
    
    self.tipsRequest.keywords = keyWords;
    self.tipsRequest.city = @"成都";
    
    [self.search AMapInputTipsSearch: self.tipsRequest];
    
    
}

#pragma mark - <AMapSearchDelegate>
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {
    //移除所有数据
    
    [self.dataArray removeAllObjects];
    
    if (response.tips.count == 0) {
        
        return;
    }
    
    //通过AmapInputTipsSearchResponse对象处理搜索结果
    for (AMapTip *p in response.tips) {
        
        AMapTip *tip = p;
        [self.dataArray addObject:tip];
    }
    self.currentTips = [NSArray arrayWithArray:self.dataArray];
   [self.tableView reloadData];
    
}

#pragma mark -<UISearchBarDelegate>

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    [self.navigationController popViewControllerAnimated:YES];
}

@end

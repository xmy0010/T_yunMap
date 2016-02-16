//
//  BusDetailViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/2/5.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusDetailViewController.h"
#import "BusWalkingCell.h"
#import "BusLineCell.h"

@interface BusDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BusDetailViewController
static NSString *const walkingCellIdentifier = @"WalkingCell";
static NSString *const BuslineCellIdentifier = @"BuslineCell";

- (NSArray *)dataArray {

    if (_dataArray == nil) {
        NSMutableArray *retArray = @[].mutableCopy;
       
        for (AMapSegment *segment in self.transit.segments) {
            if (segment.walking != nil) {
                [retArray addObject:segment.walking];
            }
            if ([segment.buslines firstObject]) {
                [retArray addObject:[segment.buslines firstObject]];
            }
        }
        
        _dataArray = retArray.copy;
    }
    
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataArray];
    [self customTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customTableView {

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BusWalkingCell" bundle:nil] forCellReuseIdentifier:walkingCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"BusLineCell" bundle:nil] forCellReuseIdentifier:BuslineCellIdentifier];
    
}

#pragma mark <UITableViewDataSource>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

     AMapSearchObject *resultObj = self.dataArray[indexPath.row];
    if ([resultObj isKindOfClass:[AMapWalking class]]) {
        return 60;
    }
    if ([resultObj isKindOfClass:[AMapBusLine class]]) {
        AMapBusLine *busline = (AMapBusLine *)resultObj;
      return   busline.viaBusStops.count * 20 + 40;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AMapSearchObject *resultObj = self.dataArray[indexPath.row];
    if ([resultObj isKindOfClass:[AMapWalking class]]) {
        BusWalkingCell *cell = [tableView dequeueReusableCellWithIdentifier:walkingCellIdentifier];
        
        cell.walking = (AMapWalking *)resultObj;
        return cell;
    }
    
    if ([resultObj isKindOfClass:[AMapBusLine class]]) {
        BusLineCell *cell = [tableView dequeueReusableCellWithIdentifier:BuslineCellIdentifier];
        
        cell.busline = (AMapBusLine *)resultObj;
        return  cell;
    }
    
    return nil;
}


@end

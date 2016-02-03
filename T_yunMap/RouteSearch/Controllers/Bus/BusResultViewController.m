//
//  BusResultViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/2/3.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusResultViewController.h"
#import "CarTableViewHeaderFooter.h"
#import "BusResultCell.h"

#define headerFooterHeight 50

@interface BusResultViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const headerIdentifier = @"header";
static NSString *const footerIdentifier = @"footer";
static NSString *const cellIdentifier = @"TableViewCell";

@implementation BusResultViewController

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  customTableView];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BusResultCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    //注册复用的header和footer
    [self.tableView registerClass:[CarTableViewHeaderFooter class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    [self.tableView registerClass:[CarTableViewHeaderFooter class] forHeaderFooterViewReuseIdentifier:footerIdentifier];
    
    self.tableView.sectionHeaderHeight = headerFooterHeight;
    self.tableView.sectionHeaderHeight = headerFooterHeight;
    self.tableView.rowHeight = 120;
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return   self.route.transits.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  
    BusResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    AMapTransit *transit = self.route.transits[indexPath.row]; 
    cell.transit = transit;
    
    return cell;
}


@end

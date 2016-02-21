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
#import "BusDetailViewController.h"

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

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.strantegy;
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section != 0) {
        return nil;
    }
    //复用不显示控件
    //    CarTableViewHeaderFooter *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    CarTableViewHeaderFooter *header = [[CarTableViewHeaderFooter alloc] init];
    header.titleLB.text = [NSString stringWithFormat:@"从%@出发", self.originName];
    header.icon.image = [UIImage imageNamed: @"default_navi_history_icon_start"];
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section != 0) {
        return nil;
    }
    
    //    CarTableViewHeaderFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    CarTableViewHeaderFooter *footer = [[CarTableViewHeaderFooter alloc] init];
    footer.titleLB.text = [NSString stringWithFormat:@"到达%@", self.destinationName];
    footer.icon.image = [UIImage imageNamed: @"default_navi_history_icon_end"];
    
    return footer;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return headerFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return headerFooterHeight;
}

#pragma mark - <UITableViewDlegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    BusDetailViewController *detailVC =[[BusDetailViewController alloc] init];
    detailVC.transit = self.route.transits[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end

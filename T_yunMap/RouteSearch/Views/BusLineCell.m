//
//  BusLineCell.m
//  T_yunMap
//
//  Created by T_yun on 16/2/16.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusLineCell.h"
#import "BusTableViewHeaderFooter.h"

#define header_footerHiehgt 40

@interface BusLineCell () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BusLineCell
static NSString *const headerIdentifier = @"header";
static NSString *const footerIdentifier = @"footer";


- (void)setBusline:(AMapBusLine *)busline {

    _busline = busline;
    [self.tableView reloadData];
    self.dataArray = self.busline.viaBusStops;
    
    if ([self.busline.type isEqualToString:@"地铁线路"]) {
        self.typeIcon.image = [UIImage imageNamed:@"default_path_pathinfo_sub_normal"];
    }
    
    self.buslineLB.text = [[self.busline.name componentsSeparatedByString:@"("] firstObject];
}

- (NSArray *)dataArray {

    if (_dataArray == nil) {
        //这句此处感觉有点多余
        _dataArray = self.busline.viaBusStops;
    }
    
    return _dataArray;
}

- (void)awakeFromNib {
    // Initialization code
    
    [self customTableView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)customTableView {

    self.tableView = [[UITableView alloc] initWithFrame:self.rightView.bounds];
    [self.rightView addSubview:self.tableView];
    
    [self.tableView registerClass:[BusTableViewHeaderFooter class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    [self.tableView registerClass:[BusTableViewHeaderFooter class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    
//    BusTableViewHeaderFooter *header = [[BusTableViewHeaderFooter alloc] init];
//    header.titleLB.text = self.busline.departureStop.name;
//    header.icon.image = [UIImage imageNamed: @"default_navi_history_icon_start"];
//    self.tableView.tableHeaderView = header;
//    
//    BusTableViewHeaderFooter *footer = [[BusTableViewHeaderFooter alloc] init];
//    footer.titleLB.text = self.busline.arrivalStop.name;
//    footer.icon.image = [UIImage imageNamed:@"default_navi_history_icon_end"];
//    self.tableView.tableFooterView = footer;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark <UITableViewDataSource, UITableViewDelegate>

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 20;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return header_footerHiehgt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return header_footerHiehgt;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section != 0) {
        return nil;
    }
    //复用不显示控件
    //    CarTableViewHeaderFooter *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    BusTableViewHeaderFooter *header = [[BusTableViewHeaderFooter alloc] init];
    header.titleLB.text = self.busline.departureStop.name;
    header.icon.image = [UIImage imageNamed: @"default_navi_history_icon_start"];
    
    return header;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (section != 0) {
        return nil;
    }
    //复用不显示控件
    //    CarTableViewHeaderFooter *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    BusTableViewHeaderFooter *footer = [[BusTableViewHeaderFooter alloc] init];
    footer.titleLB.text = self.busline.arrivalStop.name;
    footer.icon.image = [UIImage imageNamed: @"default_navi_history_icon_end"];
    
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    AMapBusStop *stop = self.dataArray[indexPath.row];
    cell.textLabel.text = stop.name;
    
    return cell;
}

//cell的姿势图tableView尺寸Bug 可能因为初始化之后cell自身尺寸变化而tableView没有跟着变化
- (void)layoutSubviews {

    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}


@end

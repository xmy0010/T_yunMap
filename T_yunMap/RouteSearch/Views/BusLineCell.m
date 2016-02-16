//
//  BusLineCell.m
//  T_yunMap
//
//  Created by T_yun on 16/2/16.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "BusLineCell.h"

@interface BusLineCell () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BusLineCell

- (void)setBusline:(AMapBusLine *)busline {

    _busline = busline;
    [self.tableView reloadData];
}

- (NSArray *)dataArray {

    if (_dataArray == nil) {
        _dataArray = self.busline.viaBusStops;
    }
    
    return _dataArray;
}

- (void)awakeFromNib {
    // Initialization code
    if ([self.busline.type isEqualToString:@"地铁线路"]) {
        self.typeIcon.image = [UIImage imageNamed:@"default_path_pathinfo_sub_normal"];
    }
    
    self.buslineLB.text = [[self.busline.name componentsSeparatedByString:@"("] firstObject];
    
    [self customTableView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)customTableView {

    self.tableView = [[UITableView alloc] initWithFrame:self.rightView.bounds];
    [self.rightView addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
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

@end

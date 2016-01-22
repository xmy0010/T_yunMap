//
//  CarDetailViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CarDetailViewController.h"
#import "CarTableViewHeaderFooter.h"

#define headerFooterHeight 50

@interface CarDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const headerIdentifier = @"header";
static NSString *const footerIdentifier = @"footer";
@implementation CarDetailViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
//此处上一级视图还没有消失 固写上一级视图的hidden = yes还会调用 所有不能显示出来
//    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
//    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"驾车路线详情";
    
    [self customTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customTableView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.xmy_width, self.view.xmy_height) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    //注册复用的header和footer
    [self.tableView registerClass:[CarTableViewHeaderFooter class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    [self.tableView registerClass:[CarTableViewHeaderFooter class] forHeaderFooterViewReuseIdentifier:footerIdentifier];
    
    self.tableView.sectionHeaderHeight = headerFooterHeight;
    self.tableView.sectionHeaderHeight = headerFooterHeight;
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.steps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma 暂时测试 稍后自定义Cell
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    AMapStep *step = self.steps[indexPath.row];
    
    cell.textLabel.text = step.road;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CarTableViewHeaderFooter *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    header.titleLB.text = [NSString stringWithFormat:@"从%@出发", self.originName];
    header.icon.image = [UIImage imageNamed: @"default_navi_history_icon_start"];
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    CarTableViewHeaderFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
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


@end

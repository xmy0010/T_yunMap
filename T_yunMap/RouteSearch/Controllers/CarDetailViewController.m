//
//  CarDetailViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CarDetailViewController.h"
#import "CarTableViewHeaderFooter.h"
#import "CarTableViewCell.h"

#define headerFooterHeight 50
#define kRowHeight 70

#define kKey  [NSString stringWithFormat:@"%ld", indexPath.row]

@interface CarDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *cellHeightDict;

@end

static NSString *const headerIdentifier = @"header";
static NSString *const footerIdentifier = @"footer";
static NSString *const cellIdentifier = @"CarTableViewCell";

@implementation CarDetailViewController

- (NSMutableDictionary *)cellHeightDict {

    if (_cellHeightDict == nil) {
        _cellHeightDict = @{}.mutableCopy;
    }
    
    return _cellHeightDict;
}

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
    

    [self customRightItem];
    [self customTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customRightItem {

    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target: self action:@selector(rightBarButtonItemPressed:)];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)customTableView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.xmy_width, self.view.xmy_height) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CarTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    //注册复用的header和footer
    [self.tableView registerClass:[CarTableViewHeaderFooter class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    [self.tableView registerClass:[CarTableViewHeaderFooter class] forHeaderFooterViewReuseIdentifier:footerIdentifier];
    
    self.tableView.sectionHeaderHeight = headerFooterHeight;
    self.tableView.sectionHeaderHeight = headerFooterHeight;
    self.tableView.rowHeight = 95;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark Action

- (void)rightBarButtonItemPressed:(UIBarButtonItem *)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.steps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    AMapStep *step = self.steps[indexPath.row];
    cell.step = step;
    
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


@end

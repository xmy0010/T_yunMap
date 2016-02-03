//
//  CarResultViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/22.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "CarResultViewController.h"
#import "MAMapView+Singleton.h"
#import "CarDetailViewController.h"

#define kCaloriePerMinute 3.75

@interface CarResultViewController ()

@property (strong, nonatomic) IBOutlet UIView *backgroudView;

@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *approximatelyTime;

@property (weak, nonatomic) IBOutlet UILabel *routeOne;
@property (weak, nonatomic) IBOutlet UILabel *routeTwo;
@property (weak, nonatomic) IBOutlet UILabel *routeThree;

@property (nonatomic, strong) NSArray *steps;

@end

@implementation CarResultViewController


- (void)viewDidAppear:(BOOL)animated {

    
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    //移除添加到地图上面的图层
    NSMutableArray *cleanArr = @[].mutableCopy;
    for (id overlay in [MAMapView shareMap].overlays) {
        
        [cleanArr addObject:overlay];
    }
    
    MAMapView *map = [MAMapView shareMap];
    [map removeOverlays:cleanArr];
    //移除annotetion
    [map removeAnnotations:map.annotations];
    
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupSubviews];
    
    [self costomMapView];
   
}

- (void)setupSubviews {

//    @property (nonatomic, copy) AMapGeoPoint *origin; //!< 起点坐标
//    @property (nonatomic, copy) AMapGeoPoint *destination; //!< 终点坐标
//    
//    @property (nonatomic, assign) CGFloat  taxiCost; //!< 出租车费用（单位：元）
//    @property (nonatomic, strong) NSArray *paths; //!< 步行、驾车方案列表 AMapPath 数组
//    @property (nonatomic, strong) NSArray *transits; //!< 公交换乘方案列表 AMapTransit 数组
//    
//    @property (nonatomic, assign) NSInteger  distance; //!< 起点和终点的距离
//    @property (nonatomic, assign) NSInteger  duration; //!< 预计耗时（单位：秒）
//    @property (nonatomic, copy)   NSString  *strategy; //!< 导航策略
//    @property (nonatomic, strong) NSArray   *steps; //!< 导航路段 AMapStep数组
//    @property (nonatomic, assign) CGFloat    tolls; //!< 此方案费用（单位：元）
//    @property (nonatomic, assign) NSInteger  tollDistance; //!< 此方案收费路段长度（单位：米）
    
//    // 基础信息
//    @property (nonatomic, copy)   NSString  *instruction; //!< 行走指示
//    @property (nonatomic, copy)   NSString  *orientation; //!< 方向
//    @property (nonatomic, copy)   NSString  *road; //!< 道路名称
//    @property (nonatomic, assign) NSInteger  distance; //!< 此路段长度（单位：米）
//    @property (nonatomic, assign) NSInteger  duration; //!< 此路段预计耗时（单位：秒）
//    @property (nonatomic, copy)   NSString  *polyline; //!< 此路段坐标点串
//    @property (nonatomic, copy)   NSString  *action; //!< 导航主要动作
//    @property (nonatomic, copy)   NSString  *assistantAction; //!< 导航辅助动作
//    @property (nonatomic, assign) CGFloat    tolls; //!< 此段收费（单位：元）
//    @property (nonatomic, assign) NSInteger  tollDistance; //!< 收费路段长度（单位：米）
//    @property (nonatomic, copy)   NSString  *tollRoad; //!< 主要收费路段
 
    
    AMapPath *path = [self.aMapRoute.paths firstObject];
    NSArray *steps = path.steps;
    
    for (int index; index < steps.count; index++) {
        
        AMapStep *step = steps[index];
        if (index == 0) {
            self.routeOne.text = step.road;
        }
        if (index == steps.count / 2) {
            if (steps.count / 2 == 0) {
                self.routeTwo.text = @"";
            }
            self.routeTwo.text = step.road;
        }
        if (index == steps.count - 1) {
            self.routeThree.text = step.road;
        }
        
    }
    

    self.taxiCost.text = [NSString stringWithFormat:@"出租费用:%.1f元", self.aMapRoute.taxiCost];
    NSInteger minute = path.duration / 60;
    self.approximatelyTime.text = [NSString stringWithFormat:@"预计耗时:%ld分钟", minute > 1 ? minute : 1];
    self.distance.text = [NSString stringWithFormat:@"总长:%ld米", path.distance];
    
    //步行不要出租车费用改为消耗热量
    if (self.isFootSerach == YES) {
        self.taxiCost.text = [NSString stringWithFormat:@"燃烧%.2f大卡", minute * kCaloriePerMinute];
        self.taxiCost.textColor = [UIColor redColor];
    }
}

- (void)costomMapView {

    MAMapView *map = [MAMapView shareMap];
    map.frame = CGRectMake(0, 0, self.view.xmy_width, self.view.xmy_height - kCarCustomViewHeight);
    [self.view addSubview:map];
    
    if (self.aMapRoute == nil) {
        return;
    }
    
    
    
    //通过AMapNavigationSearchResponse对象处理搜索结果
    AMapRoute *route = self.aMapRoute;
    AMapPath *path = [route.paths firstObject];
    NSArray *steps = path.steps;
    self.steps = steps;
    
    NSMutableArray *routePolies = @[].mutableCopy;
    for (AMapStep *step in steps) {
        
        NSString *polyline = step.polyline;
        NSArray *polies = [polyline componentsSeparatedByString:@";"];
        for (NSString *poly in polies) {
            
            [routePolies addObject:poly];
        }
    }
    
    //设置地图显示中心点
    CLLocationCoordinate2D originCoordinate2D = CLLocationCoordinate2DMake(route.origin.latitude, route.origin.longitude);
    CLLocationCoordinate2D destinationCoordinate2D = CLLocationCoordinate2DMake(route.destination.latitude, route.destination.longitude);
    [map setCenterCoordinate:originCoordinate2D animated:YES];
    [map setZoomLevel:15 animated:YES];
    
   //将起点和终点加入到地图上
    MAPointAnnotation *originPoint = [[MAPointAnnotation alloc] init];
    originPoint.coordinate = originCoordinate2D;
    originPoint.title = @"起点";
    originPoint.subtitle = self.originName;
    
    MAPointAnnotation *destinationPoint = [[MAPointAnnotation alloc] init];
    destinationPoint.coordinate = destinationCoordinate2D;
    destinationPoint.title = @"终点";
    destinationPoint.subtitle = self.destinationName;
    
    [map addAnnotation:originPoint];
    [map addAnnotation:destinationPoint];
    
    
    
    
    /**绘制折线*/
    
    
    //1.构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[routePolies.count];
    for (int index = 0; index < routePolies.count; index++) {
        NSArray *coordinateArr = [routePolies[index] componentsSeparatedByString:@","];
        
        //        NSLog(@"--%d, %f, %f",index, [coordinateArr.firstObject floatValue], [coordinateArr.lastObject floatValue]);
        commonPolylineCoords[index].longitude = [coordinateArr.firstObject floatValue];
        commonPolylineCoords[index].latitude = [coordinateArr.lastObject floatValue];
    }
    
    //2.构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:routePolies.count];
    
    //3.在地图上添加折线对象
    [map addOverlay:commonPolyline];
}

#pragma mark Actions
- (IBAction)detailItemPressed:(UIBarButtonItem *)sender {
    
    
    CarDetailViewController *carDetailVC = [[CarDetailViewController alloc] init];
    
    carDetailVC.steps = self.steps;
//    carDetailVC.backgroundView = self.backgroudView;
    carDetailVC.originName = self.originName;
    carDetailVC.destinationName = self.destinationName;
    
    [self.navigationController pushViewController:carDetailVC animated:YES];
}



@end

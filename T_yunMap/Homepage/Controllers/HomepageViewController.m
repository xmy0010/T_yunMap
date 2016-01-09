//
//  HomepageViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/5.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "HomepageViewController.h"
#import "UIView+XMYExtension.h"
#import "TitleButton.h"
#import "TypeSettingView.h"
#import "CustomAnnotationView.h"

static const CGFloat ButtonWidth_Height = 40.;
#define TypeButtonY  ScreenSize.height / 2

@interface HomepageViewController () <MAMapViewDelegate, AMapSearchDelegate> {

    MAMapView *_mapView;
    UIView *_upView;
    AMapSearchAPI *_aroundSearch;
    AMapSearchAPI *_routeSearch;
    
}

@property (nonatomic, strong) TypeSettingView *typeView;

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self customMap];
//    [self customUpView];
    
    
    [self setupSearchAPI];
    [self setupRouteSearch];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(37, 104);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [_mapView addAnnotation:pointAnnotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**logo 指南针 缩放相关*/
- (void)setupCompass {

    _mapView.logoCenter = CGPointMake(self.view.xmy_width - 50 , self.view.xmy_height - 50);
    
    //设置指南针位置
    _mapView.showsCompass = YES;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    
    //设置比例尺位置
    _mapView.showsScale = YES;
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
}

/**设置地图手势相关*/
- (void)setupGestures {

    _mapView.zoomEnabled = YES;
    
    _mapView.zoomLevel = 5;
    
    _mapView.scrollEnabled = YES;
    _mapView.rotateEnabled = YES;
    _mapView.rotateCameraEnabled = YES;
}

- (void)customMap {

    [MAMapServices sharedServices].apiKey = Gaode_key;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.xmy_width, self.view.xmy_height)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    [self setupCompass]; // 设置指南针 比例尺
    [self setupGestures]; //设置手势
    
    //开启用户定位
    _mapView.showsUserLocation = YES;
    //自定义定位图层
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    //地图跟着位置移动
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    
    //后台定位
    _mapView.pausesLocationUpdatesAutomatically = NO;
    _mapView.allowsBackgroundLocationUpdates = YES;
   
}

- (void)customUpView {

    _upView = [[UIView alloc] initWithFrame:self.view.bounds];
    _upView.backgroundColor = [UIColor clearColor];
    _upView.userInteractionEnabled = YES;
    [self.view addSubview:_upView];
    
     [self customRightButtons];
    
    CGFloat viewWidth = ScreenSize.width - 2 * Space_Normal_Eight;
    CGFloat viewHeight = 140;
    CGRect rect = CGRectMake(Space_Normal_Eight, (ScreenSize.height - viewHeight) / 2, viewWidth, viewHeight);
    TypeSettingView *typeView = [[TypeSettingView alloc] initWithInsideViewFrame:rect inView:self.view mapView:_mapView];
    self.typeView = typeView;
}

- (void)customRightButtons {

    
    UIButton *mapTypeButton = [[UIButton alloc] init];
    [_upView addSubview:mapTypeButton];
    mapTypeButton.frame = CGRectMake(_upView.xmy_width - 50, TypeButtonY, ButtonWidth_Height, ButtonWidth_Height);
    [mapTypeButton addTarget:self action:@selector(mapTypeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [mapTypeButton setImage:[UIImage imageNamed:@"homepage_typechose_button"] forState:UIControlStateNormal];
  
}

#pragma mark - AMapSearchAPI
/**周边兴趣点搜索*/
- (void)setupSearchAPI {

    _aroundSearch = [[AMapSearchAPI alloc] init];
    _aroundSearch.delegate = self;
    
    //构造AMapPOIAroundSearchRequest对象 设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    request.keywords = @"方恒";
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = @"餐饮服务|生活服务";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    [_aroundSearch AMapPOIAroundSearch:request];
}

/**路径导航搜索*/
- (void)setupRouteSearch {

    _routeSearch = [[AMapSearchAPI alloc] init];
    _routeSearch.delegate = self;
    
    //构造AMapDrivingRouteSearchRequest对象 设置驾车路径规划请求参数
    AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
    request.origin = [AMapGeoPoint locationWithLatitude:30.662221 longitude:104.041367];
    request.destination = [AMapGeoPoint locationWithLatitude:30.69 longitude:104.06];
    /// 驾车导航策略：0-速度优先（时间）；1-费用优先（不走收费路段的最快道路）；2-距离优先；3-不走快速路；4-结合实时交通（躲避拥堵）；5-多策略（同时使用速度优先、费用优先、距离优先三个策略）；6-不走高速；7-不走高速且避免收费；8-躲避收费和拥堵；9-不走高速且躲避收费和拥堵
    request.strategy = 2;
    request.requireExtension = YES;
    
    [_routeSearch AMapDrivingRouteSearch:request];
}


#pragma mark - Action
- (void)mapTypeButtonPressed:(UIButton *)sender {

  
    [self.typeView show];
}

- (void)trafficButtonPressed:(UIButton *)sender {
    
    if (_mapView.isShowTraffic == YES) {
        _mapView.showTraffic = NO;
    } else {
        _mapView.showTraffic = YES;
    }
    
}

/**获取地理位置信息*/
- (void)getGeoCoderInfoWith:(id)object {
    
    
    CLLocationCoordinate2D coordinate;
    //获取当前大头针指向的经纬度所在位置
    //进行地理编码与反编码
    if ([object performSelector:@selector(coordinate)]) {
        coordinate = [object coordinate];
    }
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return ;
        }
        CLPlacemark *placemark = [placemarks firstObject];
        NSDictionary *address = placemark.addressDictionary;
        
        NSString *sublocality = address[@"SubLocality"];
        NSString *city = address[@"City"];
        NSString *state = address[@"State"];
        NSString *subtitleStr = [NSString stringWithFormat:@"%@%@%@", state, city, sublocality];
       
        if ([object isKindOfClass:[MAPointAnnotation class]]) {
            
            MAPointAnnotation *annotation = (MAPointAnnotation *)object;
            annotation.title = address[@"Street"];
            annotation.subtitle = subtitleStr;
        } else if ([object isKindOfClass:[MAUserLocation class]]) {
        
            MAUserLocation *location = (MAUserLocation *)object;
            location.title = address[@"Street"];
            location.subtitle = subtitleStr;
        }
        
    }];
}

#pragma mark -Gesture

- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate {

    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = coordinate;
    pointAnnotation.title = @"大头针";
    pointAnnotation.subtitle = @"添加的大头针";
    
    [_mapView addAnnotation:pointAnnotation];
    
    MACircle *circle = [MACircle circleWithCenterCoordinate:coordinate radius:24];
    [_mapView addOverlay:circle]; //会回调该覆盖物
    
    
    
    
}


#pragma mark - Location

/**定位更新*/
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {

    if (updatingLocation) {
        
        CLLocationCoordinate2D coordinate = userLocation.coordinate;
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                return ;
            }
            CLPlacemark *placemark = [placemarks firstObject];
            NSDictionary *address = placemark.addressDictionary;
            
            userLocation.title = address[@"Street"];
            NSString *sublocality = address[@"SubLocality"];
            NSString *city = address[@"City"];
            NSString *state = address[@"State"];
            NSString *subtitleStr = [NSString stringWithFormat:@"%@%@%@", state, city, sublocality];
            userLocation.subtitle = subtitleStr;
        }];

    }
    _mapView.zoomLevel = 13;
}

/**地图添加图层调用*/
//自定义定位精度对应的MACircleView
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay {

    if (overlay == mapView.userLocationAccuracyCircle) {
        
        
        MACircleView *accuracyCircleView = [[MACircleView alloc] initWithCircle:overlay];
        
        NSLog(@"%f", accuracyCircleView.circle.radius);
        accuracyCircleView.lineWidth = 1.f;
        accuracyCircleView.strokeColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        accuracyCircleView.fillColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0.8];
        accuracyCircleView.lineDash = YES;
        
        return accuracyCircleView;
    }
    
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        
        circleView.lineWidth = 5.f;
        circleView.strokeColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        circleView.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.4];
        circleView.lineDash = YES;
        
        return circleView;
    }
    
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 8.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.6];
        polylineView.lineJoinType = kMALineJoinRound; //连接类型
        polylineView.lineCapType = kMALineCapRound; //断点类型
        
        return polylineView;
    }
    
    return nil;
}

/**自定义userLocation对应的annotationView*/




#pragma mark - <MAMapViewDelegate>

/**地图添加点回调*/
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {

    [self getGeoCoderInfoWith:annotation];
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        
        static NSString *userLocationStyleReuseIndetifier = @"UserLocationStyleReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil) {
            
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationStyleReuseIndetifier];
        }
       // annotationView.image = [UIImage imageNamed: @"default_common_loc_logo_normal"];
        annotationView.canShowCallout = YES;
        
        
        return annotationView;
    }
    
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *annotationReuserIndentifier = @"PointReuse";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationReuserIndentifier];
        
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationReuserIndentifier];
        }
 
        annotationView.image = [UIImage imageNamed:@"default_common_loc_logo_normal"];
        annotationView.canShowCallout = NO; //自定义calloutView
        //设置中心店偏移 使标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark <AMapSearchDelegate>

//周边兴趣搜索回调
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {

    if (response.pois.count == 0) {
        
        return;
    }
    
    //通过AMapPOISearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion :%@", response.suggestion];
    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.name];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place:%@", result);

}

/**路径搜索回调*/
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {

    if (response.route == nil) {
        return;
    }
    
    //通过AMapNavigationSearchResponse对象处理搜索结果
    AMapRoute *route = response.route;
    AMapPath *path = [route.paths firstObject];
    NSArray *steps = path.steps;
    
    NSMutableArray *routePolies = @[].mutableCopy;
    for (AMapStep *step in steps) {
        
        NSString *polyline = step.polyline;
        NSArray *polies = [polyline componentsSeparatedByString:@";"];
        for (NSString *poly in polies) {
            
            [routePolies addObject:poly];
        }
    }
    
    /**绘制折线*/
   
    //1.构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[routePolies.count];
    CLLocationCoordinate2D commonPolylineCoords__[2];
    commonPolylineCoords__[0].latitude = 30.662221;
    commonPolylineCoords__[0].longitude = 104.041367;
    
    commonPolylineCoords__[1].latitude = 30.69;
    commonPolylineCoords__[1].longitude = 104.06;

    
    for (int index = 0; index < routePolies.count; index++) {
        NSArray *coordinateArr = [routePolies[index] componentsSeparatedByString:@","];
        
        
        commonPolylineCoords[index].latitude = [coordinateArr.firstObject floatValue];
        commonPolylineCoords[index].longitude = [coordinateArr.lastObject floatValue];
    }
    
    //2.构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords__ count:routePolies.count];
    
    //3.在地图上添加折线对象
    [_mapView addOverlay:commonPolyline];
    
    
    
    //NSString *route = [NSString stringWithFormat:@"Navi:%@", [response.route formattedDescription]];
    NSLog(@"%@", routePolies);
    
}

@end

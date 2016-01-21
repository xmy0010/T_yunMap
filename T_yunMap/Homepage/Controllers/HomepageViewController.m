//
//  HomepageViewController.m
//  T_yunMap
//
//  Created by T_yun on 16/1/5.
//  Copyright © 2016年 T_yun. All rights reserved.
//


#import "HomepageViewController.h"
#import "HomepageNavigationController.h"
#import "UIView+XMYExtension.h"
#import "TypeSettingView.h"
#import "CustomAnnotationView.h"
#import "ZoomView.h"
#import "ToolBarView.h"

#import "SearchTabBarController.h"
#import "ProvinceCollectionViewController.h"

//测试
#import "WeatherResultViewController.h"

static const CGFloat kButtonWidth_Height = 40.;
static const CGFloat kZoomViewWidth = 49;
static const CGFloat kZoomViewHeight = 98;




@interface HomepageViewController () <MAMapViewDelegate, AMapSearchDelegate> {
    
    AMapSearchAPI *_search;
    AMapSearchAPI *_aroundSearch;
    AMapSearchAPI *_routeSearch;
    
}

/**测试用*/
@property (nonatomic, strong) WeatherResultViewController *vc;

@property (nonatomic, strong) TypeSettingView *typeView;

@end

@implementation HomepageViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self customMap];
    [self customUpView];
    
    
    [self weatherSearchTest];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**logo 指南针 缩放相关*/
- (void)setupCompass {

//    _mapView.logoCenter = CGPointMake(self.view.xmy_width - Space_Normal_Ten * 5 , self.view.xmy_height - Space_Normal_Ten * 5);
    //将Logo设置到地图外
    _mapView.logoCenter = CGPointMake(-100, -100);
    
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

/**地图视图*/
- (void)customMap {

    [MAMapServices sharedServices].apiKey = Gaode_key;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.xmy_width, self.view.xmy_height)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    [self setupCompass]; // 设置指南针 比例尺
    [self setupGestures]; //设置手势
#warning 暂时关闭用户定位
    //开启用户定位
    _mapView.showsUserLocation = NO;
    //自定义定位图层
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    //地图跟着位置移动
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    
    //后台定位
    _mapView.pausesLocationUpdatesAutomatically = NO;
    _mapView.allowsBackgroundLocationUpdates = YES;
    

}

/**覆盖在地图上的功能性控件*/
- (void)customUpView {

    [self customZoomView];
    
    [self customRightButtons];
    
    [self customTypeSettingView];
    
    [self customToolBarView];
    
    
}

- (void)customToolBarView {
    
    CGFloat marginX = Space_Normal_Eight;
    CGFloat marginY = self.view.xmy_height - ToolBar_Height - Space_Normal_Eight;
    CGFloat width = self.view.xmy_width - Space_Normal_Eight * 2;
    ToolBarView *toolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(marginX, marginY, width, ToolBar_Height)];
    
    [self.view addSubview:toolBarView];
    
    
    __weak typeof(self)weakSelf = self;
    toolBarView.RouteButtonBlock = ^(UIButton *sender) {
    
        [weakSelf.navigationController pushViewController:[[SearchTabBarController alloc] init] animated:YES];
    };
    
    toolBarView.ServiceButtonBlock = ^(UIButton *sender) {
    
#warning code here..
        //this is test
      
        if (_vc != nil) {
              [self.navigationController pushViewController:_vc animated:YES];
        }
      
       
    };
    
    toolBarView.WeatherButtonBlock = ^(UIButton *sender) {
        
        ProvinceCollectionViewController *provinceVC = [[ProvinceCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewLayout alloc] init]];
        [weakSelf.navigationController pushViewController:provinceVC animated:YES];
    };
}

- (void)customTypeSettingView {

    CGFloat viewWidth = ScreenSize.width - 2 * Space_Normal_Eight;
    CGFloat viewHeight = 140;
    CGRect rect = CGRectMake(Space_Normal_Eight, (ScreenSize.height - viewHeight) / 2, viewWidth, viewHeight);
    TypeSettingView *typeView = [[TypeSettingView alloc] initWithInsideViewFrame:rect inView:self.view mapView:_mapView];
    self.typeView = typeView;
    
}

- (void)customRightButtons {

    
    UIButton *mapTypeButton = [[UIButton alloc] init];
    [self.view addSubview:mapTypeButton];
    mapTypeButton.frame = CGRectMake(Space_Normal_Eight, self.view.xmy_height / 8, kButtonWidth_Height, kButtonWidth_Height);
    [mapTypeButton addTarget:self action:@selector(mapTypeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [mapTypeButton setBackgroundImage:[UIImage imageNamed:@"default_main_layer_btn_normal"] forState:UIControlStateNormal];
    mapTypeButton.layer.cornerRadius = 5.;
    mapTypeButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    UIButton *layerCleanButton = [[UIButton alloc] init];
    [self.view addSubview:layerCleanButton];
    layerCleanButton.frame = CGRectMake(Space_Normal_Eight, CGRectGetMaxY(mapTypeButton.frame) + Space_Normal_Eight, kButtonWidth_Height, kButtonWidth_Height);
    [layerCleanButton addTarget:self action:@selector(layerCleanButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [layerCleanButton setBackgroundImage:[UIImage imageNamed:@"delete_nav_s"] forState:UIControlStateNormal];
    layerCleanButton.layer.cornerRadius = 5.;
    layerCleanButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    UIButton *userLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:userLocationButton];
    userLocationButton.frame = CGRectMake(Space_Normal_Eight, self.view.xmy_height - ToolBar_Height - kButtonWidth_Height - Space_Normal_Eight * 2, kButtonWidth_Height, kButtonWidth_Height);
    [userLocationButton setBackgroundImage:[UIImage imageNamed:@"verify_code_button_highlighted"] forState:UIControlStateNormal];
    [userLocationButton addTarget:self action:@selector(userLocationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

/**自定义地图镜头远近控制的视图*/
- (void)customZoomView {

    ZoomView *zoomView = [[ZoomView alloc] initWithFrame:CGRectMake(self.view.xmy_width - kZoomViewWidth - Space_Normal_Eight, self.view.xmy_height -  ToolBar_Height - kZoomViewHeight - Space_Normal_Ten, kZoomViewWidth, kZoomViewHeight)];
    [self.view addSubview:zoomView];
    zoomView.backgroundColor = [UIColor clearColor];
    
    __weak typeof(zoomView)weakZoomView = zoomView;
    zoomView.ZoomInButtonBlock = ^(UIButton *sender) {
        
        weakZoomView.zoomOutButton.enabled = YES;
        if (_mapView.zoomLevel < 19) {
            
            sender.enabled = YES;
            _mapView.zoomLevel += 2;
        } else {
            
            [SVProgressHUD showInfoWithStatus:@"已是最近镜头"];
            sender.enabled = NO;
        }
    };
    
    zoomView.ZoomOutButtonBlock = ^(UIButton *sender) {
    
        weakZoomView.zoomInButton.enabled = YES;
        if (_mapView.zoomLevel - 1 >= 3) {
            
            sender.enabled = YES;
            _mapView.zoomLevel -= 2;
        }
        else {
            
            [SVProgressHUD showInfoWithStatus:@"已是最远镜头"];
            sender.enabled = NO;
        }
    };
    
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




/**天气搜索*/
- (void)weatherSearchTest {

    [AMapSearchServices sharedServices].apiKey = Gaode_key;
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
    request.city = @"白沙县";
    request.type = AMapWeatherTypeLive;
    
    [_search AMapWeatherSearch:request];
    
//    request.type = AMapWeatherTypeForecast;
//    [search AMapWeatherSearch:request];
}


#pragma mark - Action

- (void)userLocationButtonPressed:(UIButton *)sender {
    
    CLLocationCoordinate2D currentCoordinate = _mapView.userLocation.coordinate;
    if (currentCoordinate.latitude == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"无法定位,请检查您的网络环境"];
    } else {
    
        //设置地图显示中心点
        [_mapView setCenterCoordinate: currentCoordinate];
    }
    
}

- (void)mapTypeButtonPressed:(UIButton *)sender {

    [self.typeView show];
}

- (void)layerCleanButtonPressed:(UIButton *)sender{

    //获取自定义图层
    NSArray *overlays = _mapView.overlays;
    NSMutableArray *cleanArr = @[].mutableCopy;
    
    //弹窗
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理地图" message:@"数据清理之后不可恢复" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cleanAnnotation = [UIAlertAction actionWithTitle:@"清除自定义地点" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
       
        //移除annotetion
        [_mapView removeAnnotations:_mapView.annotations];
        
        //移除MACircle
        for (MAShape *circle in overlays) {
            if ([circle isKindOfClass:[MACircle class]]) {
                
                [cleanArr addObject:circle];
            }
        }
        [_mapView removeOverlays:cleanArr];
        [cleanArr removeAllObjects];
    }];
    
    UIAlertAction *cleanOverlys = [UIAlertAction actionWithTitle:@"清除自定义线路" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        //移除MAPolyline
        for (MAShape *circle in overlays) {
            if ([circle isKindOfClass:[MAPolyline class]]) {
                
                [cleanArr addObject:circle];
            }
        }
        [_mapView removeOverlays:cleanArr];
        
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancle];
    
    [alertController addAction:cleanAnnotation];
    [alertController addAction:cleanOverlys];
    
    [self presentViewController:alertController animated:YES completion:nil];

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
//    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
//    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion :%@", response.suggestion];
//    NSString *strPoi = @"";
//    for (AMapPOI *p in response.pois) {
//        
//        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.name];
//    }

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

    
    for (int index = 0; index < routePolies.count; index++) {
        NSArray *coordinateArr = [routePolies[index] componentsSeparatedByString:@","];
        
//        NSLog(@"--%d, %f, %f",index, [coordinateArr.firstObject floatValue], [coordinateArr.lastObject floatValue]);
        commonPolylineCoords[index].longitude = [coordinateArr.firstObject floatValue];
        commonPolylineCoords[index].latitude = [coordinateArr.lastObject floatValue];
    }

    
    //2.构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:routePolies.count];
    
    //3.在地图上添加折线对象
    [_mapView addOverlay:commonPolyline];
    
    
    
    //NSString *route = [NSString stringWithFormat:@"Navi:%@", [response.route formattedDescription]];
//    NSLog(@"%@", routePolies);
    
}

/**天气搜索回调*/
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response {
    NSMutableArray *weatherLives = @[].mutableCopy;
    if (request.type == AMapWeatherTypeLive) {
        
        if (response.lives.count == 0) {
            NSLog(@"无该地址天气");
            return;
        }
#warning 测试
        UIStoryboard *weatherSb = [UIStoryboard storyboardWithName:@"WeatherStoryboard" bundle:nil];
        self.vc = [weatherSb instantiateViewControllerWithIdentifier:@"WeatherResultViewController"];
        self.vc.live = [response.lives firstObject];
    }
}

//搜索错误的回调方法
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {

    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
}


@end

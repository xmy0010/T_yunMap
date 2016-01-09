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

@interface HomepageViewController () <MAMapViewDelegate> {

    MAMapView *_mapView;
    UIView *_upView;
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
}

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
    
    return nil;
}

/**自定义userLocation对应的annotationView*/



#pragma mark - <MAMapViewDelegate>

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

@end

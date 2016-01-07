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
    //[self customUpView];
    
    CGFloat viewWidth = ScreenSize.width - 2 * Space_Normal_Eight;
    CGFloat viewHeight = 100;
    CGRect rect = CGRectMake(Space_Normal_Eight, (ScreenSize.height - viewHeight) / 2, viewWidth, viewHeight);
    TypeSettingView *typeView = [[TypeSettingView alloc] initWithInsideViewFrame:rect inView:self.view mapView:_mapView];
    self.typeView = typeView;
    
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [_mapView addAnnotation:pointAnnotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customMap {

    [MAMapServices sharedServices].apiKey = Gaode_key;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.xmy_width, self.view.xmy_height)];
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
    
    
   
}

- (void)customUpView {

    _upView = [[UIView alloc] initWithFrame:self.view.bounds];
    _upView.backgroundColor = [UIColor clearColor];
    _upView.userInteractionEnabled = YES;
    [self.view addSubview:_upView];
    
     [self customRightButtons];
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

#pragma mark - <MAMapViewDelegate>

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {

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

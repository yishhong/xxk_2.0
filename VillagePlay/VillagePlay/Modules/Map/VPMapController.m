//
//  VPMapController.mController
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMapController.h"
#import "VPMapViewModel.h"
#import "UINavigationBar+Awesome.h"
#import "BMapKit.h"
#import "UIBarButtonItem+Custom.h"
#import "UIAlertController+MapNavigation.h"
#import "QMMapFuntion.h"


@interface VPMapController () <BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView * mapView;
//@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) VPMapViewModel *viewModel;

@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate2D;

@end

@implementation VPMapController

+ (instancetype)instantiation{
    
    return [[VPMapController alloc]init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.mapTitle;
    self.viewModel = [[VPMapViewModel alloc] init];
    
    self.locationCoordinate2D = [QMMapFuntion transformCoordinate:self.location];
    
    self.mapView = [[BMKMapView alloc] init];
    self.mapView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.mapView.mapType = BMKMapTypeStandard;
    [self.view addSubview:self.mapView];
    
//    //初始化BMKLocationService
//    self.locService = [[BMKLocationService alloc]init];
//    self.locService.delegate = self;
//    //启动LocationService
//    [self.locService startUserLocationService];

    //设置标注
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = self.locationCoordinate2D;
    annotation.title = self.mapTitle;
    [self.mapView addAnnotation:annotation];
    
    //设置区域
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    BMKCoordinateRegion region;
    region.center = self.locationCoordinate2D;
    region.span = span;
    //根据展示的大小生成一个区域
    region = [self.mapView regionThatFits:region];
    [self.mapView setRegion:region animated:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导航" style:UIBarButtonItemStylePlain target:self action:@selector(navigation)];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
    
}

#pragma mark - 开始导航
- (void)navigation{
    UIAlertController *alertCotroller = [UIAlertController mapNavigationWithLocationCoordinate2D:self.locationCoordinate2D];
    [self presentViewController:alertCotroller animated:YES completion:nil];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyMapAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

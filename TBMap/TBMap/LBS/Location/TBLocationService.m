//
//  TBLocationManager.m
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBLocationService.h"
#import "TBLocationTool.h"

@interface TBLocationService ()
{
    CLLocationCoordinate2D lastCoor;
    NSError                *serviceStartError;
    
    TBLocationModel         *_model;
}

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation TBLocationService

@synthesize locationManager;

- (id)initWithContext:(VDServiceContext *)context
{
    if (self = [super initWithContext:context]) {
        //[self setupEnvironment];
        _model = [[TBLocationModel alloc] init];
    }
    return self;
}

- (VDServiceContext <TBLocationServiceDataSource> *) getChatServiceContext
{
    return (VDServiceContext <TBLocationServiceDataSource> *)_context;
}

#pragma mark - 实现基类的方法
- (BOOL)loadModel
{
    [self performSelector:@selector(setupEnvironment) withObject:nil afterDelay:1];
    return YES;
}

- (void)clearLoadedModel
{
   
}

- (void)updateModel
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateModel) object:nil];
    
    if (_state == VDServiceStateUnloaded)
    {
        return;
    }
    
    [locationManager stopUpdatingLocation];
    [locationManager startUpdatingLocation];
    [self checkGPS];
}

- (void)stopUpdatingModel
{
    _modelState = VDServiceModelStateNormal;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateModel) object:nil];
    
    [locationManager stopUpdatingLocation];
    lastCoor = kCLLocationCoordinate2DInvalid;
   
}

- (VDModel *)getServiceModel
{
    return _model;
}

- (void)contextDidChanged:(NSString *)sel
{
    //关心context变化
}

//初始化环境
-(void)setupEnvironment
{
    XLog(@"%s:初始化环境",__FUNCTION__);
    
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    locationManager.delegate = self;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }

    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 10.0f;//kCLDistanceFilterNone
    [locationManager startUpdatingLocation];
    
    lastCoor = kCLLocationCoordinate2DInvalid;
    
    [self checkGPS];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    if ([locations count]>0) {
        CLLocation *loc = [locations objectAtIndex:0];
        CLLocationCoordinate2D coor = loc.coordinate;
        //存储用户GPS地点，用于服务端收集
        _model.coor = [TBLocationConverter wgs84ToGcj02:coor];
        
        //XLog(@"j:%f  w:%f",coor.longitude,coor.latitude);
        
        if (CLLocationCoordinate2DIsValid(lastCoor)) {
            int distance = (int)LantitudeLongitudeDist(lastCoor.longitude, lastCoor.latitude, coor.longitude, coor.latitude);
            XLog(@"位置变换，距离%d 速度：speed:%f",distance,loc.speed);
        }
        lastCoor = coor;
        
        [self modelSuccLoaded:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    if (error.code == kCLErrorDenied) {
        XLog(@"GPS拒绝访问");
        
        [self checkGPS];
        [locationManager stopUpdatingLocation];
    }
    
}

#pragma mark - Tool

//GPS状态检测
-(void)checkGPS
{
    NSError *error = [TBLocationTool GPSStatusCheck];
    if (error) {
        for (NSString *msg in error.userInfo.allValues) {
            XLog(@"%@",msg);
        }
        serviceStartError = error;
        [self modelFailLoaded:serviceStartError];
    }else {
        XLog(@"定位服务开启");
        serviceStartError = nil;
    }

}

@end

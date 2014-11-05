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
}

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation TBLocationService

@synthesize locationManager;

- (id)initWithContext:(VDServiceContext *)context
{
    if (self = [super initWithContext:context]) {
        //[self setupEnvironment];
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
    [self setupEnvironment];
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
    
    _modelState = VDServiceModelStateLoading;
    [locationManager stopUpdatingLocation];
    [locationManager startUpdatingLocation];
    
}

- (void)stopUpdatingModel
{
    _modelState = VDServiceModelStateNormal;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateModel) object:nil];
   
}

- (VDModel *)getServiceModel
{
    return nil;
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
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 10.0f;
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
        
        XLog(@"j:%f  w:%f",coor.longitude,coor.latitude);
        
        if (CLLocationCoordinate2DIsValid(lastCoor)) {
            int distance = (int)LantitudeLongitudeDist(lastCoor.longitude, lastCoor.latitude, coor.longitude, coor.latitude);
            NSLog(@"位置变换了，距离%d 速度：speed:%f",distance,loc.speed);
        }
        
        lastCoor = coor;
    }
    
    //未开始服务或者不在加载中，则不做处理
    if (_state == VDServiceStateUnloaded || _modelState == VDServiceModelStateNormal) {
        return;
    }
    _modelState = VDServiceModelStateNormal;

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error.code == kCLErrorDenied) {
        NSLog(@"GPS拒绝访问");
        
        [self checkGPS];
        [locationManager stopUpdatingLocation];
    }
    
    if (_state == VDServiceStateUnloaded || _modelState == VDServiceModelStateNormal) {
        return;
    }
    _modelState = VDServiceModelStateNormal;
    
    [self modelFailLoaded:error];

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
    }else {
        XLog(@"定位服务开启");
        serviceStartError = nil;
    }

}

@end

//
//  TBLocationManager.m
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBLocationService.h"

@interface TBLocationService ()
{
    CLLocationManager *locationManager;
}
@end

@implementation TBLocationService

- (id)initWithContext:(VDServiceContext *)context
{
    if (self = [super initWithContext:context]) {
        [self initEnvironment];
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
    return NO;
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
-(void)initEnvironment
{
    BOOL openedLocation = [CLLocationManager locationServicesEnabled];
    BOOL havePermission = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized;
    if (!openedLocation) {
        NSLog(@"%s:GPS尚未打开",__FUNCTION__);
    }
    if (!havePermission) {
        NSLog(@"%s:GPS没有权限",__FUNCTION__);
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 100.0f;
    
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if ([locations count]>0) {
        CLLocation *loc = [locations objectAtIndex:0];
        CLLocationCoordinate2D coor = loc.coordinate;
        //存储用户GPS地点，用于服务端收集
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",coor.latitude] forKey:@"lat"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",coor.longitude] forKey:@"lon"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        CLLocationCoordinate2D lastCoor = loc.coordinate;
        if (CLLocationCoordinate2DIsValid(lastCoor)) {
            int distance = (int)LantitudeLongitudeDist(lastCoor.longitude, lastCoor.latitude, coor.longitude, coor.latitude);
            NSLog(@"位置变换了，%d speed:%f",distance,loc.speed);
        }
    }
    
    //未开始服务或者不在加载中，则不做处理
    if (_state == VDServiceStateUnloaded || _modelState == VDServiceModelStateNormal) {
        return;
    }
    _modelState = VDServiceModelStateNormal;
    
    [self loadModel];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error.code == kCLErrorDenied) {
        NSLog(@"GPS拒绝访问");
        //int gpsIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"gpsIndex"];
        [locationManager stopUpdatingLocation];
    }
    
    if (_state == VDServiceStateUnloaded || _modelState == VDServiceModelStateNormal) {
        return;
    }
    _modelState = VDServiceModelStateNormal;
    
    [self modelFailLoaded:error];

}

#pragma mark - Tool

//根据经纬度计算两点的距离
#define PI 3.1415926
double LantitudeLongitudeDist(double lon1,double lat1,
                              double lon2,double lat2)
{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist;
}


@end

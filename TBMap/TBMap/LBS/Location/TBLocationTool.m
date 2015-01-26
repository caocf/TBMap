//
//  TBLocationTool.m
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBLocationTool.h"

@implementation TBLocationTool

+(NSError *)GPSStatusCheck
{
    BOOL openedLocation = [CLLocationManager locationServicesEnabled];
    BOOL havePermission = [CLLocationManager authorizationStatus] >= kCLAuthorizationStatusAuthorized;
    
    NSMutableDictionary *errorInfo = [[NSMutableDictionary alloc] init];
    NSError *error = nil;
    
    if (!openedLocation) {
        [errorInfo setObject:TBLocationServiceErrorGPSOpen forKey:@"gpsopen"];
    }
    if (!havePermission) {
        [errorInfo setObject:TBLocationServiceErrorGPSPermission forKey:@"gpspermission"];
    }
    if (!openedLocation || !havePermission) {
        error = [NSError errorWithDomain:@"GPSStatusCheck" code:0 userInfo:errorInfo];
    }
    
    return error;
}

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

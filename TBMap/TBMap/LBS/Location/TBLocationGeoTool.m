//
//  TBLocationGeoManger.m
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBLocationGeoTool.h"

@interface TBLocationGeoTool ()

@end

@implementation TBLocationGeoTool

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

-(void)gecode:(NSString *)address complete:(CompleteBlock)complete
{
    
    if (address.length == 0) {
        complete(nil);
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error || placemarks.count==0) {
            XLog(@"地址没找到");
            if (complete) {
                complete(nil);
            }
        }else   //  编码成功
        {
            if (complete) {
                complete(placemarks);
            }
            
        }
    }];
}

/*!
 *  @brief  地理反编码
 *  @param coor 经纬度
 */
- (void)reverseGeocode:(CLLocationCoordinate2D)coor complete:(CompleteBlock)complete{
    
    if (!CLLocationCoordinate2DIsValid(coor)) {
        complete(nil);
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location=[[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude];
   
    //2.反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error||placemarks.count==0) {
            XLog(@"地址没找到");
            if (complete) {
                complete(nil);
            }
        }else//编码成功
        {
            if (complete) {
                complete(placemarks);
            }
        }
       
    }];
}

@end

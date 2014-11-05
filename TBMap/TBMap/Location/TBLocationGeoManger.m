//
//  TBLocationGeoManger.m
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBLocationGeoManger.h"

@interface TBLocationGeoManger ()

@property(nonatomic,strong) CLGeocoder *geocoder;

@end

@implementation TBLocationGeoManger

- (instancetype)init
{
    self = [super init];
    if (self) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return self;
}

-(void)gecode:(NSString *)address
{
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error || placemarks.count==0) {
            
            XLog(@"地址没找到");
            
        }else   //  编码成功
        {
            //打印查看找到的所有的位置信息
            /*
             name:名称
             locality:城市
             country:国家
             postalCode:邮政编码
             */
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
                for (NSString *key in placemark.addressDictionary.allKeys) {
                    NSLog(@"%@ : %@",key,[placemark.addressDictionary objectForKey:key]);
                }
                NSLog(@"%@",[[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] objectAtIndex:0]);
            }
           
            
            //取出获取的地理信息数组中的第一个显示在界面上
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            //详细地址名称
            // self.detailAddressLabel.text=firstPlacemark.name;
            //纬度
            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
            //经度
            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
            
        }
    }];
}

/*!
 *  @brief  地理反编码
 *  @param coor 经纬度
 */
- (void)reverseGeocode:(CLLocationCoordinate2D)coor {
    
    CLLocationDegrees latitude= coor.latitude;
    CLLocationDegrees longitude= coor.longitude;
    
    CLLocation *location=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    //2.反地理编码
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error||placemarks.count==0) {
            XLog(@"地址没找到");
        }else//编码成功
        {
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
           
            for (NSString *key in firstPlacemark.addressDictionary.allKeys) {
                NSLog(@"%@ : %@",key,[firstPlacemark.addressDictionary objectForKey:key]);
            }

            //经纬度
            CLLocationCoordinate2D newcoor = firstPlacemark.location.coordinate;
        }
    }];
}

@end

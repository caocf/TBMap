//
//  TBRootViewController.m
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBRootViewController.h"
#import "TBLocationService.h"
#import "VDServiceFactory.h"
#import "TBLocationGeoTool.h"

@interface TBRootViewController ()
{
    TBLocationService *locationService;
}

@end

@implementation TBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    locationService = VDServiceFactoryGet(TBLocationService);
}


#pragma mark - 

-(IBAction)locate:(id)sender
{
    [locationService updateModel];
    
    TBLocationGeoTool *geo = [[TBLocationGeoTool alloc] init];
    
    [geo gecode:@"北京动物园" complete:^(NSArray *placemarks) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocationCoordinate2D coor = placemark.location.coordinate;
  
        XLog(@"地理编码 name=%@ locality=%@ country=%@ postalCode=%@\n经纬度%f %f",placemark.name,placemark.locality,placemark.country,placemark.postalCode,coor.longitude,coor.latitude);

    }];

    [geo reverseGeocode:CLLocationCoordinate2DMake(39.9833, 116.302) complete:^(NSArray *placemarks) {
        XLog(@"反编码：%@",[[placemarks objectAtIndex:0] name]);
    }];
}

@end

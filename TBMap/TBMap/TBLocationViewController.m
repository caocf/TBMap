//
//  TBLocationViewController.m
//  TBMap
//
//  Created by libo on 11/6/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBLocationViewController.h"

@interface TBLocationViewController ()<VDServiceDelegate>
{
    TBLocationService *locationService;
    TBLocationGeoTool *geo;
}
@end

@implementation TBLocationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    locationService = VDServiceFactoryGet(TBLocationService);
    
    
    geo = [[TBLocationGeoTool alloc] init];

}

-(void)viewWillAppear:(BOOL)animated
{
    [locationService registerObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [locationService cancelRegistration:self];
}

#pragma mark - VDServiceDelegate

- (void)serviceLoadModelFinish:(VDService *)service userInfo:(NSDictionary*)userInfo
{
    [self updateUI];
}

- (void)serviceLoadModelFailed:(VDService *)service error:(NSError *)error
{
    XLog(@"error:%@",[error localizedDescription]);
    [self updateUI];
}

- (void)serviceModelUpdated:(VDService *)service type:(NSString*)type userInfo:(NSDictionary*)userInfo
{
    [self updateUI];
}

-(void)updateUI
{
    TBLocationModel *model = (TBLocationModel *)[locationService getServiceModel];
    _currentLocation.text = [NSString stringWithFormat:@"j %f w %f",model.coor.longitude,model.coor.latitude];
}

#pragma mark - Action

- (IBAction)updateLocation:(id)sender {
    [locationService updateModel];
}

- (IBAction)queryGeo:(id)sender {
    
    [geo gecode:@"北京动物园" complete:^(NSArray *placemarks) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocationCoordinate2D coor = placemark.location.coordinate;
        
        XLog(@"地理编码 name=%@ locality=%@ country=%@ postalCode=%@\n经纬度%f %f",placemark.name,placemark.locality,placemark.country,placemark.postalCode,coor.longitude,coor.latitude);
        
    }];
}

- (IBAction)queryReverseGeo:(id)sender {
    
    [geo reverseGeocode:CLLocationCoordinate2DMake(39.9833, 116.302) complete:^(NSArray *placemarks) {
        XLog(@"反编码：%@",[[placemarks objectAtIndex:0] name]);
    }];
    
}
@end
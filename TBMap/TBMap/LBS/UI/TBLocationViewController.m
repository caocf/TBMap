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

    geo = [[TBLocationGeoTool alloc] init];
    locationService = VDServiceFactoryGet(TBLocationService);
    
    
    [self updateUI];

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
    [geo reverseGeocode:model.coor complete:^(NSArray *placemarks) {
        
        if ([placemarks count] > 0) {
            CLPlacemark *place = [placemarks firstObject];
            NSArray *form = [[place addressDictionary] objectForKey:@"FormattedAddressLines"];
            if ([form count] > 0 && ![[form objectAtIndex:0] isEqualToString:SAFE_STRING(place.name)]) {
                _currentLocation.text = [NSString stringWithFormat:@"%@ %@",[form objectAtIndex:0] ,place.name];
            }else {
                _currentLocation.text = place.name;
            }
        }
    }];

}

#pragma mark - Action

- (IBAction)updateLocation:(id)sender {
    [locationService updateModel];
}

- (IBAction)queryGeo:(id)sender {
    
    [geo gecode:_inputArea.text complete:^(NSArray *placemarks) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocationCoordinate2D coor = placemark.location.coordinate;
        
        if ([placemarks count] == 0) {
            _geoResult.text = @"地址没找到";
        }else {
            _geoResult.text = placemark.name;
        }
        XLog(@"地理编码 name=%@ locality=%@ country=%@ postalCode=%@\n经纬度%f %f",placemark.name,placemark.locality,placemark.country,placemark.postalCode,coor.longitude,coor.latitude);
        
    }];
}

- (IBAction)queryReverseGeo:(id)sender {

    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([_inputLatitude.text doubleValue], [_inputLongitude.text doubleValue]);
//    coor = CLLocationCoordinate2DMake(29.415832, 106.555555);
    
    [geo reverseGeocode:coor complete:^(NSArray *placemarks) {
        if ([placemarks count] == 0) {
            _reverseResult.text = @"地址没找到";
        }else {
            _reverseResult.text = [[placemarks firstObject] name];
        }
        XLog(@"反编码：%@",[[placemarks objectAtIndex:0] name]);
    }];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_inputArea resignFirstResponder];
    [_inputLatitude resignFirstResponder];
    [_inputLongitude resignFirstResponder];
}

@end

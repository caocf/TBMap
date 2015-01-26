//
//  TBLocationUsage
//  teambuild
//
//  Created by libo on 15-1-26.
//  Copyright (c) 2015年 sina. All rights reserved.
//

#import "TBLocationUsage.h"

@interface TBLocationUsage ()<VDServiceDelegate>
{
    TBLocationService *locationService;
    TBLocationGeoTool *geo;

}

@property (nonatomic,copy) void (^updateFinished)();

@end

@implementation TBLocationUsage

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(TBLocationUsage);

-(instancetype)init
{
    if (self = [super init]) {
       
        geo = [[TBLocationGeoTool alloc] init];
        
        locationService = VDServiceFactoryGet(TBLocationService);
        
        [locationService registerObserver:self];
    }
    return self;
}

-(void)update:(void (^)())finished
{
    self.updateFinished = finished;
    [locationService updateModel];
}

#pragma mark - VDServiceDelegate

- (void)serviceLoadModelFinish:(VDService *)service userInfo:(NSDictionary*)userInfo
{
    [self refreshData];
}

- (void)serviceLoadModelFailed:(VDService *)service error:(NSError *)error
{
    XLog(@"error:%@",[error localizedDescription]);
    [self refreshData];
}

- (void)serviceModelUpdated:(VDService *)service type:(NSString*)type userInfo:(NSDictionary*)userInfo
{
    [self refreshData];
}

-(void)refreshData
{
    if (self.updateFinished) {
        self.updateFinished();
        self.updateFinished = nil;
        [locationService performSelector:@selector(stopUpdatingModel) withObject:nil afterDelay:10];
    }
    
    TBLocationModel *model = (TBLocationModel *)[locationService getServiceModel];
    self.localCoor = model.coor;
    [geo reverseGeocode:model.coor complete:^(NSArray *placemarks) {
        
        if ([placemarks count] > 0) {
            CLPlacemark *place = [placemarks firstObject];
            self.placemark = place;
            
            NSRange cityRange = [[place locality] rangeOfString:@"市"];
            if (cityRange.location != NSNotFound) {
                self.city = [[place locality] substringToIndex:cityRange.location+1];
            }else{
                self.city = [place locality];
            }
            
            NSArray *form = [[place addressDictionary] objectForKey:@"FormattedAddressLines"];
            NSString *detailtext  = @"地址解码失败";
            if ([form count] > 0 && ![[form objectAtIndex:0] isEqualToString:SAFE_STRING(place.name)]) {
                detailtext = [NSString stringWithFormat:@"%@ %@",[form objectAtIndex:0] ,place.name];
            }else {
                detailtext = place.name;
            }
            self.detailAddress = detailtext;
            XLog(@"定位地址:%@",detailtext);
        }
    }];
    
}




- (IBAction)queryGeo:(id)sender {
    
    [geo gecode:@"动物园" complete:^(NSArray *placemarks) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocationCoordinate2D coor = placemark.location.coordinate;
        
        NSString *text = nil;
        if ([placemarks count] == 0) {
            text = @"地址没找到";
        }else {
            text = placemark.name;
        }
        XLog(@"地理编码 name=%@ locality=%@ country=%@ postalCode=%@\n经纬度%f %f",placemark.name,placemark.locality,placemark.country,placemark.postalCode,coor.longitude,coor.latitude);
        
    }];
}

- (IBAction)queryReverseGeo:(id)sender {
    
    //CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([_inputLatitude.text doubleValue], [_inputLongitude.text doubleValue]);
    //    coor = CLLocationCoordinate2DMake(29.415832, 106.555555);
    
//    [geo reverseGeocode:coor complete:^(NSArray *placemarks) {
//        NSString *text = nil;
//        if ([placemarks count] == 0) {
//            text = @"地址没找到";
//        }else {
//            text = [[placemarks firstObject] name];
//        }
//        XLog(@"反编码：%@",[[placemarks objectAtIndex:0] name]);
//    }];
    
}


@end

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
#import "TBLocationGeoManger.h"

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
    
    //116.302663  w:39.982331
    TBLocationGeoManger *geo = [[TBLocationGeoManger alloc] init];
    [geo gecode:@"北京动物园"];
    [geo reverseGeocode:CLLocationCoordinate2DMake(39.982331, 116.302663)];
}

@end

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
}

@end

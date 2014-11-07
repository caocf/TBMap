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
#import "TBLocationViewController.h"
#import "TBMapViewController.h"

@interface TBRootViewController ()
{
    TBLocationService *locationService;
}

@end

@implementation TBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}


#pragma mark - 

-(IBAction)locate:(id)sender
{
    TBLocationViewController *vc = [[TBLocationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
        
}

-(IBAction)map:(id)sender
{
    TBMapViewController *vc = [[TBMapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
    
}


@end

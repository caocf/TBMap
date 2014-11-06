//
//  TBLocationViewController.h
//  TBMap
//
//  Created by libo on 11/6/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBLocationService.h"
#import "VDServiceFactory.h"
#import "TBLocationGeoTool.h"

@interface TBLocationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *updateLocation;
@property (weak, nonatomic) IBOutlet UILabel *currentLocation;
@property (weak, nonatomic) IBOutlet UITextField *inputArea;
@property (weak, nonatomic) IBOutlet UILabel *geoResult;
@property (weak, nonatomic) IBOutlet UITextField *inputLongitude;
@property (weak, nonatomic) IBOutlet UITextField *inputLatitude;
@property (weak, nonatomic) IBOutlet UILabel *reverseResult;

- (IBAction)updateLocation:(id)sender;
- (IBAction)queryGeo:(id)sender;
- (IBAction)queryReverseGeo:(id)sender;

@end

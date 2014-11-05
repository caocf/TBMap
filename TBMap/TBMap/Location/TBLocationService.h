//
//  TBLocationManager.h
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "VDService.h"
#import "TBLocationServiceDataSource.h"

@interface TBLocationService :VDService<CLLocationManagerDelegate>

-(void)setupEnvironment;

@end

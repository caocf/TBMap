//
//  TBLocationGeoManger.h
//  TBMap
//
//  地址编码与解码
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TBLocationGeoManger : NSObject

-(void)gecode:(NSString *)address;

- (void)reverseGeocode:(CLLocationCoordinate2D)coor;

@end
